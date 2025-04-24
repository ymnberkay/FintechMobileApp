//
//  Fintech_Mobile_AppApp.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//

import SwiftUI

@main
struct Fintech_Mobile_AppApp: App {
    @StateObject var createAccountViewModel = CAViewModel()
    var body: some Scene {
        WindowGroup {
            RootView(createAccountViewModel: createAccountViewModel)
        }
    }
}
