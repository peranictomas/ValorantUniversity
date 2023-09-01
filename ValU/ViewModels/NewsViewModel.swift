//
//  NewsViewModel.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-09.
//

import Foundation
import FirebaseFirestore

class NewsViewModel: ObservableObject {
    @Published var news = [News]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("news").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("no documents")
                return
            }
            
            self.news = documents.map {  (queryDocumentSnapshot) -> News in
                let data = queryDocumentSnapshot.data()
        
                let category = data["category"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                let heading = data["heading"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                
                let news = News(category: category, author: author, content: content, heading: heading, image: image)
                return news
                
            
            }
        }
    }
    
    
    
}
