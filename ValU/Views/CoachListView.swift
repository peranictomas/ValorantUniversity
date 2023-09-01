//
//  CoachListView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-28.
//

import SwiftUI

struct CoachListView: View {
    @Binding var isOpen: Bool
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var coachEmail = ""
    @State var coachName = ""
    @State var fullName = ""
    @ObservedObject var chatroomsViewModel = ChatroomsViewModel()
    @State var userName = ""
    @State var currentCoachEmail: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(accountViewModel.coaches) { users in

                        ZStack(alignment: .leading) {
                            LinearGradient(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)], startPoint: .top, endPoint: .bottom)

                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(
                                            Color.gray
                                        )

                                    VStack {
                                        let userFirstName = users.firstName
                                        let firstNameFirstLetter = userFirstName.prefix(1)
                                        let firstLetter = String(firstNameFirstLetter)

                                        Text("\(firstLetter)")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: 70, height: 70, alignment: .center)

                                VStack(alignment: .leading) {
                                    Text("\(users.firstName) \(users.lastName)")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .lineLimit(2)
                                        .padding(.bottom, 5)

                                    Text("Rating: \(users.rating) ").font(.headline) + Text(Image(systemName: "star.fill")).foregroundColor(Color.yellow)
                                }
                                .padding(.horizontal, 5)

                                if accountViewModel.users.indices.contains(0) {
                                    if accountViewModel.users[0].coach == false{
                                        ZStack {
                                            Button {
                                                coachEmail = users.email
                                                coachName = users.firstName
                                                fullName = "\(users.firstName) \(users.lastName)"
                                                chatroomsViewModel.newCreateChatroom(userName: userName, title: fullName, coachEmail: users.email, handler: { self.isOpen = false })
                                            } label: {
                                                Image(systemName: "message.fill").foregroundColor(Color.black)
                                            }
                                        }.padding(.leading, 80)
                                    }
                                }
                                
                                
                            }
                            .padding(15)

                        }.clipShape(RoundedRectangle(cornerRadius: 15))
                    }.listRowSeparator(.hidden)
                }.listStyle(.plain)
            }.navigationTitle("Coaches")
        }.onAppear {
            Task {
                await self.accountViewModel.showCurrentUser()
            }
            self.accountViewModel.listCoaches()
            if accountViewModel.users.indices.contains(0) {
                userName = "\(accountViewModel.users[0].firstName) \(accountViewModel.users[0].lastName)"
            }
        }
    }
}

struct CoachListView_Previews: PreviewProvider {
    static var previews: some View {
        CoachListView(isOpen: .constant(true), coachEmail: "Coach", coachName: "Coach")
    }
}
