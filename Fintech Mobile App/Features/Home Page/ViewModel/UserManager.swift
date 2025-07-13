//
//  UserManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 30.06.2025.
//

import Foundation

final class UserManager: ObservableObject {
    @Published var currentUserID: String = ""
    @Published var currentResidence: String = ""
    @Published var currentFullName: String = ""
    @Published var currentDateOfBirth: String = ""
    @Published var currentAdressLine: String = ""
    @Published var currentCity: String = ""
    @Published var currentPostCode: String = ""
    @Published var currentEmail: String = ""
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    func setUserID(_ userID: String) {
        DispatchQueue.main.async {
            self.currentUserID = userID
            print("🆔 UserID updated: \(userID)")
        }
    }
}

struct User {
    let id: String
    let residence: String
    let fullName: String
    let dateOfBirth: String
    let adressLine: String
    let city: String
    let postCode: String
    let email: String
    let passCode: String
}
