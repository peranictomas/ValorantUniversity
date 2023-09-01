//
//  ARHomeView .swift
//  ValU
//
//  Created by Rayan Syed on 2021-09-21.
//

import SwiftUI
import FirebaseFirestore
import Firebase

//struct ARPageView: View {
//    @StateObject var placementSettings = PlacementSettings()
//    @State var quizScore:String = "0.0"
//    var body: some View {
//            ScrollView{
//                ARCardView(image: "ARPlanningTable", title: "Planning Table", description: "Select the map of your choice and create your own strategey by placing characters and their abilities around the map.", destination: AnyView(PlanningTableView().environmentObject(placementSettings)))
//
//                ARCardView(image: "spike_defusal", title: "Spike Defusal", description: "Practise defusing the spike so you can use the clock to your advantage during clutch moments.", destination: AnyView(SpikeDefusalView()))
//
//                ARCardView(image: "mapquiz", title: "Ascent Call Out Quiz", description: "Struggling with map callouts? Try out this quiz to learn and master all areas of Ascent! \nHigh Score: \(quizScore)%", destination: AnyView(AscentQuizView()))
                
   //         }.onAppear{getQuizScore()}
   //         .navigationBarTitle("AR Experiences")

        
   // }
    
//    func getQuizScore(){
//        let db = Firestore.firestore()
//        let userID = Auth.auth().currentUser?.email
//        do{
//            let _ = try db.collection("users").whereField("email", isEqualTo: userID).getDocuments(completion: { querySnapshot, error in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//
//                guard let docs = querySnapshot?.documents else { return }
//                for doc in docs {
//                    let ref = doc.reference
//                    if (doc.get("ascentQuizScore") == nil){
//                        ref.setData(["ascentQuizScore": "0.0"], merge: true) { error in
//                            if let error = error {
//                                print("Error writing document: \(error)")
//                            } else {
//                                print("Document successfully written!")
//                            }
//                        }
//                    }
//                    quizScore = doc.get("ascentQuizScore") as? String ?? "0.0"
//                    print(quizScore)
//                }
//            })
//        }
//    }
//}
//
//
//
//struct ARHomeView__Previews: PreviewProvider {
//    static var previews: some View {
//        ARPageView()
//    }
//}
