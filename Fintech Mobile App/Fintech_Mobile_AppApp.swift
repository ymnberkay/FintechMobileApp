//
//  Fintech_Mobile_AppApp.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//

import SwiftUI
import Firebase

@main
struct Fintech_Mobile_AppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var createAccountViewModel = CAViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            RootView(createAccountViewModel: createAccountViewModel, loginViewModel: loginViewModel)
        }
    }
}
