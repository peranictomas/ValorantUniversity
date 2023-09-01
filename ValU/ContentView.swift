//
//  ContentView.swift
//  ValorantUniversity
//
//  Created by Tomas Peranic on 2021-09-16.
//

import Firebase
import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var status = false
    @StateObject var accountViewModel = AccountViewModel()
    var body: some View {
        ZStack {
            if status {
                MainView()
            } else {
                LoginView(model: accountViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
