//
//  UserDataByEmailResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.08.2025.
//

import Foundation

// MARK: - UserDataByEmailResponse
struct UserDataByEmailResponse: Codable {
    let success: Bool
    let message: String
    let data: ReceiverUser
}

// MARK: - DataClass
struct ReceiverUser: Codable {
    let id, residence, fullName, userName: String
    let dateOfBirth, addressLine, city, postCode: String
    let email: String
}
