//
//  MessagesView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-29.
//

import simd
import SwiftUI

struct MessagesView: View {
    let chatroom: MessageModel
    @ObservedObject var messageViewModel = MessageViewModel()
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var messageField = ""
    @State var showRateSheet: Bool = false
    @State var rating: Int = 0
    @State var average: String = ""
    @State var usersName: String = ""
    @State var oneStar: Int = 0
    @State var twoStar: Int = 0
    @State var threeStar: Int = 0
    @State var fourStar: Int = 0
    @State var fiveStar: Int = 0
    @State var scoreTotal: Int = 0
    @State var responseTotal: Int = 0
    @State var allRatings = [String]()
    init(chatroom: MessageModel) {
        self.chatroom = chatroom
        messageViewModel.fetchData(docId: chatroom.id)
    }

    var body: some View {
        List {
            ForEach(messageViewModel.messages) { message in

                ZStack(alignment: .leading) {
                    LinearGradient(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)], startPoint: .top, endPoint: .bottom)
                    VStack{
                        HStack {
                            ZStack {
                                Text(message.name)
                                    .font(.system(size: 10, weight: .regular))
                                    .lineLimit(2)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .cornerRadius(5)
                            }.padding(.top, 5)
                                .padding(.leading, 5)
                        }
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text(message.content)
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                                .foregroundColor(.white)

                                .padding(.bottom, 5)

                            
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(15)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }.listRowSeparator(.hidden)

        }.listStyle(.plain)
        HStack {
            TextField("Enter message", text: $messageField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                messageViewModel.sendMessage(messageContent: messageField, docId: chatroom.id, sendersName: usersName)
                if !messageField.isEmpty {
                    messageField = ""
                }
            }, label: {
                Text("send")
            })
        }

        .onAppear {
            Task {
                await self.accountViewModel.showCurrentUser()
            }
            accountViewModel.getCurrentRating(coachEmail: chatroom.title)
            if accountViewModel.users.indices.contains(0) {
                usersName = "\(accountViewModel.users[0].firstName) \(accountViewModel.users[0].lastName)"
            }
        }
        .navigationBarTitle(chatroom.names)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if accountViewModel.users.indices.contains(0) {
                    if accountViewModel.users[0].coach == false {
                        Button {
                            showRateSheet.toggle()
                        } label: {
                            Label("Rate", systemImage: "r.circle")
                        }
                    }
                }
            }
        }.accentColor(.red)
        .sheet(isPresented: $showRateSheet, content: {
            Text("Submit a rating for \(chatroom.names)").padding(.bottom, 60)

            ZStack {
                starView.overlay(overlayView.mask(starView))
            }

        })
    }

    private var starView: some View {
        HStack {
            ForEach(1 ..< 6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index

                            let update = updateRating(userRating: rating)
                        }
                    }
            }

        }.onAppear {
        }
        .onDisappear {
            accountViewModel.addRating(coachEmail: chatroom.title, rating: allRatings)

            accountViewModel.updateCoachRating(coachEmail: chatroom.title, newRating: average)
        }
    }

    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }.allowsHitTesting(false)
    }

    func updateRating(userRating: Int) {
        oneStar = 0
        twoStar = 0
        threeStar = 0
        fourStar = 0
        fiveStar = 0
        allRatings.removeAll()
        var i = 0
        while i < accountViewModel.responseTotal.count {
            let rate = accountViewModel.responseTotal[i]
            allRatings.append(rate)
            if accountViewModel.responseTotal[i] == "1" {
                oneStar += 1
            }
            if accountViewModel.responseTotal[i] == "2" {
                twoStar += 1
            }
            if accountViewModel.responseTotal[i] == "3" {
                threeStar += 1
            }
            if accountViewModel.responseTotal[i] == "4" {
                fourStar += 1
            }
            if accountViewModel.responseTotal[i] == "5" {
                fiveStar += 1
            }
            i = i + 1
        }
        if userRating == 1 {
            oneStar += 1
        }
        if userRating == 2 {
            twoStar += 1
        }
        if userRating == 3 {
            threeStar += 1
        }
        if userRating == 4 {
            fourStar += 1
        }
        if userRating == 5 {
            fiveStar += 1
        }

        scoreTotal = (fiveStar * 5) + (fourStar * 4) + (threeStar * 3) + (twoStar * 2) + (oneStar * 1)

        responseTotal = fiveStar + fourStar + threeStar + twoStar + oneStar

        average = "\(round((Double(scoreTotal) / Double(responseTotal)) * 100) / 100)"
        allRatings.append(String(userRating))
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatroom: MessageModel(id: "10101", title: "Hello", joinCode: 10, names: "Hello"))
    }
}
