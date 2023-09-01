//
//  MainView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-10-03.
//

import SwiftUI

struct MainView: View {
    var accountView = AccountViewModel()
    var body: some View {
        TabView {
            TutorialsListView(videoID: "FoYc1wMLNf0").tabItem {
                Label("Tutorials", systemImage: "list.bullet.circle.fill")
            }
            CoachListView(isOpen: .constant(true)).tabItem {
                Label("Coaches", systemImage: "person.3.fill")
            }
            HomePageView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            ProfileView(matchID: "aAA").tabItem {
                Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
            }
            MessageView().tabItem {
                Label("Message", systemImage: "message.fill")
            }


        }.environmentObject(accountView)
            .onAppear {
                UITabBar.appearance().barTintColor = .white
            }.accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
