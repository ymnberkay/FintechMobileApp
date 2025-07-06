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
        self.currentUserID = userID
        fetchUserData()
    }
    
    func fetchUserData() {
        guard !currentUserID.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        // Simulated API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Mock data
            self.currentUser = User(id: self.currentUserID,
                                    residence: self.currentResidence,
                                    fullName: self.currentFullName,
                                    dateOfBirth: self.currentDateOfBirth,
                                    adressLine: self.currentAdressLine,
                                    city: self.currentCity,
                                    postCode: self.currentPostCode,
                                    email: self.currentEmail,
                                    passCode: "Empty")
            self.isLoading = false
        }
    }
    
    func logout() {
        currentUserID = ""
        currentUser = nil
        errorMessage = nil
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
