//
//  Recipient.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.08.2025.
//

import Foundation

struct Recipient: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let email: String
    let amount: String
    let profileImageURL: String?
    
    init(name: String, email: String, amount: String, profileImageURL: String? = nil) {
        self.name = name
        self.email = email
        self.amount = amount
        self.profileImageURL = profileImageURL
    }
}
