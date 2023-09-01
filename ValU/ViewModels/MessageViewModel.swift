//
//  MessageViewModel.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-29.
//

import Firebase
import Foundation

struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var name: String
}

class MessageViewModel: ObservableObject {
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    func sendMessage(messageContent: String, docId: String, sendersName: String) {
        if user != nil {
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: [
                "sentAt": Date(),
                "displayName": sendersName,
                "content": messageContent,
                "sender": user!.uid])
        }
    }

    func fetchData(docId: String) {
        if user != nil {
            db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({ snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("no doc")
                    return
                }
                self.messages = documents.map { docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["content"] as? String ?? ""
                    let displayName = data["displayName"] as? String ?? ""
                    return Message(id: docId, content: content, name: displayName)
                }
            })
        }
    }
}
