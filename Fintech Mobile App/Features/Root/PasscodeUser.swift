//
//  PasscodeUser.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

import SwiftData

@Model
final class PasscodeUser {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var phoneNumber: String
    
    init(id: String, name: String, email: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
