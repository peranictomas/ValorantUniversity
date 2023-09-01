//
//  MessageView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-29.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var chatroomsViewModel = ChatroomsViewModel()
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var isCoach = true
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(chatroomsViewModel.chatrooms, id: \.title) { chatroom in
                        NavigationLink(destination: MessagesView(chatroom: chatroom)) {
                            ZStack(alignment: .leading) {
                                LinearGradient(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)], startPoint: .top, endPoint: .bottom)

                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(
                                                Color.gray
                                            )

                                        VStack {
                                            let userFirstName = chatroom.names
                                            let firstNameFirstLetter = userFirstName.prefix(1)
                                            let firstLetter = String(firstNameFirstLetter)

                                            Text("\(firstLetter)")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .frame(width: 70, height: 70, alignment: .center)

                                    VStack(alignment: .leading) {
                                        Text(chatroom.names)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .lineLimit(2)
                                            .padding(.bottom, 5)
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .padding(15)

                            }.clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }.onDelete(perform: delete)
                        .listRowSeparator(.hidden)
                }.listStyle(.plain)
                    .toolbar{
                        if isCoach == false{
                        EditButton()
                        }
                    }
            }.navigationTitle("Messages")
        }.onAppear {
            if accountViewModel.users.indices.contains(0) {
                if accountViewModel.users[0].coach == true {
                    chatroomsViewModel.fetchCoachData()
                    isCoach = true
                } else {
                    chatroomsViewModel.fetchData()
                    isCoach = false
                }
            }
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            if isCoach == true {
            } else {
                chatroomsViewModel.deleteCoachChatroom(coachEmail: chatroomsViewModel.chatrooms[index].title)
            }
        }

        chatroomsViewModel.chatrooms.remove(atOffsets: offsets)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
