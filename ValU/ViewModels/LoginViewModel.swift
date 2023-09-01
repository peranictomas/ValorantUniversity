//
//  LoginViewModel.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-20.
//

import Firebase
import SwiftUI

struct LoginViewModel: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Establishing a connection to our database
class Delegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
