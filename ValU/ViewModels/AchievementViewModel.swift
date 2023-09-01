//
//  AchievementViewMode.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-24.
//

import Foundation
import FirebaseFirestore
import Firebase

class AchievementViewModel: ObservableObject{
    @Published var userAchievements = [Achievement]()
    @Published var allAchievements = [Achievement]()
    
    func populateList(){
        let planningAchievement = Achievement(id:"planningTable",title: "I Got a Plan!", description: "Use the AR Planning Table to Create Your Own Strategies", unlocked: false, percentCompleted: 0.0, score: 25)
        let ascentQuizAchievement = Achievement(id:"spikeDefusal", title: "Defuse Kit!", description: "Give a shot at defusing the AR Spike.", unlocked: false, percentCompleted: 0.0,  score: 25)
        let spikeDefusalAchievement = Achievement(id:"ascentQuiz", title: "Ascent Master", description: "Achieve a Score of 100 Percent in the Ascent AR Quiz", unlocked: false, percentCompleted: 0.0,  score: 100)
        let watchTutorialsAchievement = Achievement(id:"watchTutorials", title: "Grab The Popcorn!", description: "Watch a Total of 5 Valorant Tutorials!", unlocked: false, percentCompleted: 0.0,  score: 100)
        let coachingAchievement = Achievement(id:"coaching", title: "Need Backup", description: "Get in touch with one of the coaches in Valorant University", unlocked: false, percentCompleted: 0.0,  score: 100)
        let statsAchievement = Achievement(id:"stats", title: "Analysis!", description: "Use the stat tracker to look up your match results", unlocked: false, percentCompleted: 0.0,  score: 100)
        allAchievements.append(contentsOf: [planningAchievement, ascentQuizAchievement, spikeDefusalAchievement, watchTutorialsAchievement, coachingAchievement, statsAchievement])
    }
    
    func updateAchievementPercent(achievementId:String , percentCompleted: CGFloat){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.email
        db.collection("users").whereField("email", isEqualTo: userID).getDocuments { (snapshot, err) in

           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in snapshot!.documents {
                 if document == document {
                  print(document.documentID)
                     let docRef = db.collection("users").document(document.documentID).collection("achievements").document("\(achievementId)")
                     docRef.updateData([
                        "percentCompleted": percentCompleted,
                        "unlocked": true
                     ]){error in
                         if let error = error{
                             print("\(error)")
                         }else{
                             print("Updated successfully")
                         }
                     }
                     
                    }
                }
           }
       }
        
    }
    
    
    func fetchData(){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.email
        db.collection("users").whereField("email", isEqualTo: userID).getDocuments { (snapshot, err) in

           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in snapshot!.documents {
                 if document == document {
                  print(document.documentID)
                     db.collection("users").document(document.documentID).collection("achievements").addSnapshotListener {(querySnapshot, error) in
                         guard let documents = querySnapshot?.documents else{
                             print("no documents")
                             return
                         }

                         self.userAchievements = documents.map {  (queryDocumentSnapshot) -> Achievement in
                             let data = queryDocumentSnapshot.data()
                             
                             let id = data["id"] as? String ?? ""
                             let title = data["title"] as? String ?? ""
                             let description = data["description"] as? String ?? ""
                             let score = data["score"] as? Int ?? 0
                             let unlocked = data["unlocked"] as? Bool ?? false
                             let percentCompleted = data["percentCompleted"] as? CGFloat ?? 0.0

                             let userAchievements = Achievement(id: id, title: title, description: description, unlocked: unlocked, percentCompleted: percentCompleted, score: score)
                             return userAchievements


                         }
                     }


                    }
                }
           }
       }
    }



    func addAchievementsToDatabase(){
            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser?.email

            do{
                let _ = try db.collection("users").whereField("email", isEqualTo: userID).getDocuments(completion: { querySnapshot, error in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }

                    guard let docs = querySnapshot?.documents else { return }
                    for doc in docs {
                        let ref = doc.reference
                        
                        doc.reference.collection("achievements").getDocuments()
                        {
                            (querySnapshot, err) in

                            if let err = err
                            {
                                print("Error getting documents: \(err)");
                            }
                            else
                            {
                                var count = 0
                                for document in querySnapshot!.documents {
                                    count += 1
                                    print("\(document.documentID) => \(document.data())");
                                }
                                if(count == 0){
                                    self.populateList()
                                    print("writing list to database")
                                    for item in self.allAchievements{
                                        ref.collection("achievements").document("\(item.id)").setData([
                                            "id": item.id,
                                            "title": item.title,
                                            "description": item.description,
                                            "percentCompleted": item.percentCompleted,
                                            "score": item.score,
                                            "unlocked": item.unlocked
                                        ], merge: true)
  
                                            
                                        
                                    }

                                }

                                print("Count = \(count)");
                            }
                        }
                    }
                })
            }
    }

    
}
