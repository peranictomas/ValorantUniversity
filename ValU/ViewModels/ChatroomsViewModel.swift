//
//  MessageModel.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-29.
//

import Firebase
import FirebaseFirestore
import Foundation

struct MessageModel: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var joinCode: Int
    var names: String
}

struct JoinModel: Codable, Hashable {
    var joinCode: Int
}

class ChatroomsViewModel: ObservableObject {
    @Published var chatrooms = [MessageModel]()
    @Published var joincodes = [JoinModel]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    // Firebase error alerts
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var coachEmailArray = [String]()

    func data() {
    }

    func fetchData() {
        if user != nil {
            db.collection("chatrooms").whereField("player", isEqualTo: user!.email).addSnapshotListener({ snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                self.chatrooms = documents.map({ docSnapshot -> MessageModel in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["coach"] as? String ?? ""
                    let joinCode = data["joinCode"] as? Int ?? -1
                    let names = data["coachName"] as? String ?? ""
                    return MessageModel(id: docId, title: title, joinCode: joinCode, names: names)
                })
            })
        }
    }

    func fetchCoachData() {
        if user != nil {
            db.collection("chatrooms").whereField("coach", isEqualTo: user!.email).addSnapshotListener({ snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                self.chatrooms = documents.map({ docSnapshot -> MessageModel in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["player"] as? String ?? ""
                    let joinCode = data["joinCode"] as? Int ?? -1
                    let names = data["chatName"] as? String ?? ""
                    return MessageModel(id: docId, title: title, joinCode: joinCode, names: names)
                })
            })
        }
    }

//
//    func createChatroom(userName: String, title: String, coachEmail: String, handler: @escaping () -> Void) {
//        // check if its already been created
//        print(title)
//        if user != nil {
//            db.collection("chatrooms").addDocument(data: [
//                "coachName": title,
//                "chatName": "\(userName) & \(title)",
//                "joinCode": Int.random(in: 10000 ..< 99999),
//                "player": user!.email,
//                "coach": coachEmail]) { err in
//
//                if let err = err {
//                    print("error adding doc \(err)")
//                } else {
//                    handler()
//                }
//            }
//        }
//    }

    func newCreateChatroom(userName: String, title: String, coachEmail: String, handler: @escaping () -> Void) {
        var check = false
        if user == nil {
            print("found it")
        }

        db.collection("chatrooms").whereField("player", isEqualTo: user!.email).whereField("coach", isEqualTo: coachEmail).addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot else {
                print("No documents")
                return
            }

            documents.documentChanges.forEach { diff in
                let coach = diff.document.get("coach") as? String ?? ""
                print("Coach found \(coach)")
                check = true
            }
            if check == false {
                print("Coach not found, creating chatroom")
                if self.user != nil {
                    self.db.collection("chatrooms").addDocument(data: [
                        "coachName": title,
                        "chatName": "\(userName)",
                        "joinCode": Int.random(in: 10000 ..< 99999),
                        "player": self.user!.email,
                        "coach": coachEmail]) { err in

                        if let err = err {
                            print("error adding doc \(err)")
                        } else {
                            handler()
                        }
                    }
                }
            }
        }
    }

    func joinChatroom(code: Int, handler: @escaping () -> Void) {
        if user != nil {
            db.collection("chatrooms").whereField("player", isEqualTo: user!.email).addSnapshotListener({ snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("no document")
                    return
                }
                self.chatrooms = documents.map({ docSnapshot -> MessageModel in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["coachName"] as? String ?? ""
                    let names = data["chatName"] as? String ?? ""
                    return MessageModel(id: docId, title: title, joinCode: code, names: names)
                })
            })
        }
    }

    func deleteCoachChatroom(coachEmail: String) {
        db.collection("chatrooms").whereField("player", isEqualTo: user!.email).whereField("coach", isEqualTo: coachEmail).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        print(document.documentID)
                        self.db.collection("chatrooms").document(document.documentID).delete { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed")
                                self.alertMessage = "Chatroom deleted (MAKE THE RATING HERE)"
                                self.alert.toggle()
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}
