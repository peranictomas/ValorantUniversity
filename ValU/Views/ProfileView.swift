//
//  ProfileView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-10-05.
//

import SwiftUI

struct ProfileView: View {
    
    @State var matchID: String
    @State private var isShowingMatchSheet = false
    @EnvironmentObject var model: AccountViewModel
    @ObservedObject var viewModel = ChatroomsViewModel()
    var body: some View {
        NavigationView {
            List{
                ForEach(model.allMatches){ match in
                    HStack{
                        Text(match.matchId).font(.headline).bold()
                        
                        Button("View Match") {
                            isShowingMatchSheet = true
                            matchID = match.matchId
                        }.padding(.trailing, 100)
                    }
                }
            }
            .sheet(isPresented:
                $isShowingMatchSheet, content: {
                MatchView(matchID: $matchID)
            })
            .listStyle(GroupedListStyle())
            .navigationTitle("Matches")
            .onAppear(){
                Task{
                    await self.model.showCurrentUser()
                }
//                self.model.getMatches()
            }
            .refreshable {
//                self.model.allMatches.removeAll()
                self.model.getMatches()
            }
    }
}
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchID: "AAA")
    }
}
