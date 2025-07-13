//
//  User.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 13.07.2025.
//

struct User: Codable {
    var id: String
    var residence: String?
    var fullName: String?
    var dateOfBirth: String?
    var adressLine: String?
    var city: String?
    var postCode: String?
    var email: String?
    var passCode: String?
    
    init(id: String) {
        self.id = id
    }
}

struct PersonalInfo: Codable {
    let success: Bool
    let message: String
    let data: User
}

