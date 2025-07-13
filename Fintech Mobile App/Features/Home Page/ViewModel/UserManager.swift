//
//  UserManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 30.06.2025.
//

import Foundation

final class UserManager: ObservableObject {
    
    @Published var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    func setUserID(_ userID: String) {
        DispatchQueue.main.async {
            if self.currentUser == nil {
                self.currentUser = User(id: userID)
            } else {
                self.currentUser?.id = userID
            }
            print("🆔 UserID updated: \(userID)")
        }
    }
    
    func fetchUserInfo(_ userId: String) async {
        if let response = await NetworkManager.networkManager.get(path: .PIFetchFullData(userId: userId), type: PersonalInfo.self) {
            self.isLoading = response.success
            self.currentUser = response.data
        } else {
            
        }
    }
}

