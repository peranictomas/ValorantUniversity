//
//  TutorialsViewModel.swift
//  ValU
//
//  Created by Rayan Syed on 2021-09-16.
//

import Firebase
import FirebaseFirestore
import Foundation

class TutorialsViewModel: ObservableObject {
    @Published var tutorials = [Tutorial]()

    @Published var tutorial: Tutorial = Tutorial(title: "", agent: "", map: "", phase: "", tags: [], videoID: "", userEmail: "")

    // Firebase error alerts
    @Published var alert = false
    @Published var alertMessage = ""

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("tutorials").addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                let data = queryDocumentSnapshot.data()

                let title = data["title"] as? String ?? ""
                let agent = data["agent"] as? String ?? ""
                let map = data["map"] as? String ?? ""
                let phase = data["phase"] as? String ?? ""
                let tags = data["tags"] as? Array<String> ?? [""]
                let videoID = data["videoID"] as? String ?? ""
                let userEmail = data["userEmail"] as? String ?? ""

                return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
            }
        }
    }

    func addTutorial(tutorial: Tutorial) {
        do {
            _ = try db.collection("tutorials").document().setData(["title": tutorial.title.lowercased(), "agent": tutorial.agent, "map": tutorial.map,
                                                                   "tags": tutorial.tags, "videoID": tutorial.videoID, "userEmail": tutorial.userEmail])
        } catch {
            print(error)
        }
    }

    func save() {
        addTutorial(tutorial: tutorial)
    }

    func filterMyTutorials(userEmail: String) {
        db.collection("tutorials").whereField("userEmail", isEqualTo: userEmail).addSnapshotListener { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                let data = queryDocumentSnapshot.data()

                let title = data["title"] as? String ?? ""
                let agent = data["agent"] as? String ?? ""
                let map = data["map"] as? String ?? ""
                let phase = data["phase"] as? String ?? ""
                let tags = data["tags"] as? Array<String> ?? [""]
                let videoID = data["videoID"] as? String ?? ""
                let userEmail = data["userEmail"] as? String ?? ""

                return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
            }
        }
    }

    func deleteTutorial(videoID: String, userEmail: String) {
        db.collection("tutorials").whereField("videoID", isEqualTo: videoID).whereField("userEmail", isEqualTo: userEmail).getDocuments { snapshot, err in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        print(document.documentID)
                        self.db.collection("tutorials").document(document.documentID).delete { err in
                            if let err = err {
                                print("Error removing document: (err)")
                            } else {
                                print("Document successfully removed!")
                                self.alertMessage = "Tutorial Successfully Removed"
                                self.alert.toggle()
                                return
                            }
                        }
                    }
                }
            }
        }
    }

    func filter(title: String, agent: String, map: String, phase: String) {
        // SHOW ALL
        if (title == "") && (agent == "All Agents") && (map == "All Maps") && (phase == "All Phases")
        {
            db.collection("tutorials").addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // SHOW ALL FILTERS
        if (title == "") && (agent != "All Agents") && (map != "All Maps") && (phase != "All Phases")
        {
            db.collection("tutorials").whereField("agent", isEqualTo: agent).whereField("map", isEqualTo: map).whereField("phase", isEqualTo: phase).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW AGENT
        if (title == "") && (agent != "All Agents") && (map == "All Maps") && (phase == "All Phases")
        {
            db.collection("tutorials").whereField("agent", isEqualTo: agent).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW MAP
        if (title == "") && (agent == "All Agents") && (map != "All Maps") && (phase == "All Phases")
        {
            db.collection("tutorials").whereField("map", isEqualTo: map).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW PHASE
        if (title == "") && (agent == "All Agents") && (map == "All Maps") && (phase != "All Phases")
        {
            db.collection("tutorials").whereField("phase", isEqualTo: phase).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW AGENT AND MAP
        if (title == "") && (agent != "All Agents") && (map != "All Maps") && (phase == "All Phases")
        {
            db.collection("tutorials").whereField("agent", isEqualTo: agent).whereField("map", isEqualTo: map).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW AGENT AND PHASE
        if (title == "") && (agent != "All Agents") && (map == "All Maps") && (phase != "All Phases")
        {
            db.collection("tutorials").whereField("agent", isEqualTo: agent).whereField("phase", isEqualTo: phase).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }

        // TITLE EMPTY SHOW MAP AND PHASE
        if (title == "") && (agent == "All Agents") && (map != "All Maps") && (phase != "All Phases")
        {
            db.collection("tutorials").whereField("map", isEqualTo: map).whereField("phase", isEqualTo: phase).addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.tutorials = documents.map { (queryDocumentSnapshot) -> Tutorial in
                    let data = queryDocumentSnapshot.data()

                    let title = data["title"] as? String ?? ""
                    let agent = data["agent"] as? String ?? ""
                    let map = data["map"] as? String ?? ""
                    let phase = data["phase"] as? String ?? ""
                    let tags = data["tags"] as? Array<String> ?? [""]
                    let videoID = data["videoID"] as? String ?? ""
                    let userEmail = data["userEmail"] as? String ?? ""

                    return Tutorial(title: title, agent: agent, map: map, phase: phase, tags: tags, videoID: videoID, userEmail: userEmail)
                }
            }
        }
    }
}
