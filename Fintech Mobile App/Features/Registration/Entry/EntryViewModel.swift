//
//  EntryViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

import Foundation

final class EntryViewModel: ObservableObject {
    @Published var shouldShowPasscode = false
    
    init() {
        checkIfUserLoggedIn()
    }
    private func checkIfUserLoggedIn() {
        let hasLoggedInBefore = UserDefaults.standard.bool(forKey: "hasLoggedInBefore")
        if hasLoggedInBefore {
            // shouldShowPasscode = true
        }
    }
    
    
}
