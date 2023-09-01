//
//  AccountViewModel.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-23.
//

import Alamofire
import Firebase
import FirebaseFirestore
import SwiftUI

class AccountViewModel: ObservableObject {
    private var db = Firestore.firestore()

    var players = [Player]()

    @Published var users = [ProfileData]()
    @Published var rankedMatches: [MatchModel] = []
    @Published var allMatches: [MatchModel] = []
    @Published var coaches = [CoachListData]()

    @Published var email = ""
    @Published var password = ""
    @Published var isRegistered = false
    @Published var register_email = ""
    @Published var register_password = ""
    @Published var verify_password = ""
    @Published var linkSent = false
    var counter = 0
    // Firebase error alerts
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var responseTotal = [String]()

    // User status
    @AppStorage("log_status") var status = false

    // Loading ...
    @Published var isLoading = false

    // First and Last Name
    @Published var firstName = ""
    @Published var lastName = ""

    // Coach Flag
    @Published var isCoach = false

    // Valorant ID
    @Published var riotID = ""
    @Published var riotTagLine = ""

    // API Key
    private var apiKey = "RGAPI-0ada78a3-a1ba-4741-bbbd-5607420e9848"

    // PUUID
    @Published var riotPUUID = ""

    func resetPassword() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter the email for the account's password you would like to reset.", preferredStyle: .alert)
        alert.addTextField { password in
            password.placeholder = "val@university.com"
        }

        let proceed = UIAlertAction(title: "Reset", style: .default) { _ in
            // Send reset link to user
            if alert.textFields![0].text! != "" {
                withAnimation {
                    self.isLoading.toggle()
                }

                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { error in

                    withAnimation {
                        self.isLoading.toggle()
                    }

                    if error != nil {
                        self.alertMessage = error!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    // Alert User
                    self.alertMessage = "Password reset link was sent to your inbox"
                    self.alert.toggle()
                }
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        // Adding actions to the given UIAlert's
        alert.addAction(proceed)
        alert.addAction(cancel)

        // Displaying the alert messages to the UI
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }

    func login() {
        // check to see if all TextFields are filled in
        if email == "" || password == "" {
            alertMessage = "Please fill out all the fields."
            alert.toggle()
            return
        }

        withAnimation {
            self.isLoading.toggle()
        }

        Auth.auth().signIn(withEmail: email, password: password) { _, error in

            withAnimation {
                self.isLoading.toggle()
            }

            if error != nil {
                self.alertMessage = error!.localizedDescription
                self.alert.toggle()
                return
            }
            // Check to see if they have verified their email
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified {
                self.alertMessage = "Make sure you verified your email address."
                self.alert.toggle()
                // If not verified log out
                try! Auth.auth().signOut()
                return
            }
            // If they are verified set their status to true when loggin in
            withAnimation {
                self.status = true
            }
        }
    }

    func signup() {
        // Check
        if register_email == "" || register_password == "" || verify_password == "" || firstName == "" || lastName == "" {
            alertMessage = "Please fill out all the fields."
            alert.toggle()
            return
        }

        if register_password != verify_password {
            alertMessage = "Your passwords do not match"
            alert.toggle()
            return
        }

        withAnimation {
            self.isLoading.toggle()
        }

        // Add the user to the firebase
        Auth.auth().createUser(withEmail: register_email, password: register_password) { result, error in

            withAnimation {
                self.isLoading.toggle()
            }

            // Adding User information to the database
            // Add a new document with a generated ID
            var ref: DocumentReference?
            ref = self.db.collection("users").addDocument(data: [
                "firstName": self.firstName,
                "lastName": self.lastName,
                "coach": self.isCoach,
                "email": self.register_email,
                "puuid": "",
                "overallRating": "0",
                "rating": ["0"],
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }

            if error != nil {
                self.alertMessage = error!.localizedDescription
                self.alert.toggle()
                return
            }
            // Send the verification link
            result?.user.sendEmailVerification(completion: { error in
                if error != nil {
                    self.alertMessage = error!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.alertMessage = "Please verify your email, a link was sent to your inbox."
                self.alert.toggle()
            })
        }
    }

    func logOut() {
        try! Auth.auth().signOut()
        withAnimation {
            self.status = false
        }

        email = ""
        password = ""
        register_password = ""
        verify_password = ""
    }

    func listCoaches() {
        db.collection("users").whereField("coach", isEqualTo: true).addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.coaches = documents.map { (queryDocumentSnapshot) -> CoachListData in
                let data = queryDocumentSnapshot.data()

                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let coach = data["coach"] as? Bool ?? false
                let email = data["email"] as? String ?? ""
                let puuid = data["puuid"] as? String ?? ""
                let rating = data["overallRating"] as? String ?? ""

                return CoachListData(firstName: firstName, lastName: lastName, email: email, coach: coach, puuid: puuid, rating: rating)
            }
        }
    }

    func showCurrentUser() async -> ProfileData {
        do {
            let userID = Auth.auth().currentUser?.email

            db.collection("users").whereField("email", isEqualTo: userID).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.users = documents.map { (queryDocumentSnapshot) -> ProfileData in
                    let data = queryDocumentSnapshot.data()

                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let coach = data["coach"] as? Bool ?? false
                    let email = data["email"] as? String ?? ""
                    let puuid = data["puuid"] as? String ?? ""
                    let rating = data["overallRating"] as? String ?? ""
                    self.riotPUUID = puuid

                    return ProfileData(firstName: firstName, lastName: lastName, email: email, coach: coach, puuid: puuid, rating: rating)
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        return ProfileData(firstName: "", lastName: "", email: "", coach: false, puuid: "", rating: "")
    }

    func checkValorantID() async {
        let userID = Auth.auth().currentUser?.email
        guard let url = URL(string: "https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id/\(riotID)/\(riotTagLine)?api_key=\(apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                // make sure this JSON is in the format we expect
                // convert data to json
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a dictionary
                    if let data = json["puuid"] as? String {
                        self.db.collection("users")
                            .whereField("email", isEqualTo: userID)
                            .getDocuments { querySnapshot, _ in
                                let document = querySnapshot!.documents.first
                                document!.reference.updateData([
                                    "puuid": data,
                                ])
                                self.alertMessage = "You are all set! Now you can track your stats in profile section"
                                self.alert.toggle()
                                return
                            }

                    } else {
                        // Suppress the warning by pushing UI to the main queue instead of background
                        DispatchQueue.main.sync { [weak self] in
                            self?.alertMessage = "Account doesnt exist make sure your Account Name and tagline are correct"
                            self?.alert.toggle()
                            return
                        }
                    }
                }
            } catch let error as NSError {
                print("This account doesnt exist: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    func getMatches() -> MatchModel {
        allMatches.removeAll()
        // await showCurrentUser()
        guard let url = URL(string: "https://na.api.riotgames.com/val/match/v1/matchlists/by-puuid/\(riotPUUID)?api_key=\(apiKey)") else { return MatchModel(matchId: "") }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data, error == nil else { return }

            do {
                // make sure this JSON is in the format we expect
                // convert data to json
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // try to read out a dictionary
                    if let data = json["history"] as? [[String: Any]] {
                        for dict in data {
                            DispatchQueue.main.sync {
                                self.allMatches.append(MatchModel(matchId: dict["matchId"] as! String))
                                print(self.allMatches.count)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
        }

        task.resume()
        return MatchModel(matchId: "")
    }

    func getRankedMatches() async -> MatchModel {
        rankedMatches.removeAll()
        for match in allMatches {
            guard let url = URL(string: "https://na.api.riotgames.com/val/match/v1/matches/\(match.matchId)?api_key=\(apiKey)") else { return MatchModel(matchId: "") }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    // make sure this JSON is in the format we expect
                    // convert data to json
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // try to read out a dictionary
                        if let data = json["matchInfo"] as? [String: Any] {
                            if (data["queueId"] as! String) == "competitive" {
                                DispatchQueue.main.sync {
                                    self.rankedMatches.append(MatchModel(matchId: data["matchId"] as! String))
                                    print(self.rankedMatches.count)
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Error: \(error.localizedDescription)")
                }
            }

            task.resume()
        }
        return MatchModel(matchId: "")
    }

    func getPuuid(tagLine: String, gameName: String, completion: @escaping (_ error: Error?, _ puuidResponse: PuuidResponse?) -> Void) {
        let parameters = ["api_key": "RGAPI-0ada78a3-a1ba-4741-bbbd-5607420e9848"]
        let url = "https://americas.api.riotgames.com/riot/account/v1/accounts/by-riot-id/\(gameName)/\(tagLine)"
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("didnt get any data from API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let apiResults = try decoder.decode(PuuidResponse.self, from: data)

                completion(nil, apiResults)
            } catch let error {
                print(error)
            }
        }
    }

    func getMatchListByPuuid(puuid: String, completion: @escaping (_ error: Error?, _ matchListResponse: MatchList?) -> Void) {
        let parameters = ["api_key": "RGAPI-0ada78a3-a1ba-4741-bbbd-5607420e9848"]
        let url = "https://na.api.riotgames.com/val/match/v1/matchlists/by-puuid/\(puuid)"
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("didnt get any data from API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let apiResults = try decoder.decode(MatchList.self, from: data)

                completion(nil, apiResults)
            } catch let error {
                print(error)
            }
        }
    }

    func getMatchInfoByGameId(gameId: String, completion: @escaping (_ error: Error?, _ matchInfoResponse: MatchInfoResponse?) -> Void) {
        let parameters = ["api_key": "RGAPI-0ada78a3-a1ba-4741-bbbd-5607420e9848"]
        let url = "https://na.api.riotgames.com/val/match/v1/matches/\(gameId)"
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("didnt get any data from API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let apiResults = try decoder.decode(MatchInfoResponse.self, from: data)

                completion(nil, apiResults)
            } catch let error {
                print(error)
            }
        }
    }

    func getCurrentRating(coachEmail: String) {
        db.collection("users").whereField("email", isEqualTo: "\(coachEmail)").addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot else {
                print("No documents")
                return
            }

            documents.documentChanges.forEach { diff in
                let rating = diff.document.get("rating") as? Array<String> ?? [""]
                self.responseTotal = rating
            }
        }
    }

    func addRating(coachEmail: String, rating: [String]) {
        db.collection("users").whereField("email", isEqualTo: "\(coachEmail)").getDocuments { snapshot, err in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        print(document.documentID)
                        let doc = self.db.collection("users").document(document.documentID)
                        doc.updateData(["rating": rating]) { error in
                            if let error = error {
                                print("\(error)")
                            } else {
                                print("added successfully")
                            }
                        }
                    }
                }
            }
        }
    }

    func updateCoachRating(coachEmail: String, newRating: String) {
        db.collection("users").whereField("email", isEqualTo: "\(coachEmail)").getDocuments { snapshot, err in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        print(document.documentID)
                        let doc = self.db.collection("users").document(document.documentID)
                        doc.updateData(["overallRating": newRating]) { error in
                            if let error = error {
                                print("\(error)")
                            } else {
                                print("Updated successfully")
                            }
                        }
                    }
                }
            }
        }
    }
}
