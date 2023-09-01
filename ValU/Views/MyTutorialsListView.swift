//
//  MyTutorialsListView.swift
//  ValU
//
//  Created by Wahab  on 2021-10-07.
//

import Firebase
import SwiftUI

struct MyTutorialsListView: View {
    @ObservedObject private var viewModel = TutorialsViewModel()
    @State var videoID = ""
    @State var userEmail = ""
    @State var tutorialID = ""

    var body: some View {
        VStack {
            Text("My Tutorials")
            List(viewModel.tutorials) { tutorial in
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(tutorial.title).font(.headline)
                        HStack {
                            ForEach(tutorial.tags, id: \.self) { tag in
                                HStack {
                                    Text(tag).font(.caption2)
                                }
                            }
                        }
                        Text(tutorial.videoID).font(.caption2)
                    }
            
                }
                HStack{
                    Button("Delete") {
                        videoID = tutorial.videoID
                        tutorialID = tutorial.id
                        userEmail = tutorial.userEmail
                        delete(videoID: videoID, userEmail: userEmail)
                    }
                    .padding(.trailing, 100)
                    .foregroundColor(Color.red)
                }
            }
            .navigationBarTitle("Tutorials")
            .onAppear {
                self.viewModel.filterMyTutorials(userEmail: Auth.auth().currentUser?.email ?? "")
            }
        }
        .alert(isPresented: $viewModel.alert, content: {
            Alert(title: Text("Message"), message: Text(viewModel.alertMessage), dismissButton: .destructive(Text("Ok")))
        })
    }

    func delete(videoID: String, userEmail: String) {
        viewModel.deleteTutorial(videoID: videoID, userEmail: userEmail)
    }
}

struct MyTutorialsListView_Previews: PreviewProvider {
    static var previews: some View {
        MyTutorialsListView()
    }
}
