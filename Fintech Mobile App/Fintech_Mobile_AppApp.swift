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
    @StateObject private var coordinator = NavigationCoordinator()
    @StateObject private var userManager = UserManager()
    @StateObject var createAccountViewModel = CAViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var homePageViewModel = HomePageViewModel()
    @StateObject var spendingViewModel = SpendingViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView(createAccountViewModel: createAccountViewModel, loginViewModel: loginViewModel, homePageViewModel: HomePageViewModel(), spendingViewModel: spendingViewModel)
                .environmentObject(userManager)
                .environmentObject(coordinator)
        }
    }
}
