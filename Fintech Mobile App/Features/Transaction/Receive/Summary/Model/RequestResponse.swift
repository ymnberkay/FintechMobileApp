//
//  RequestResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.09.2025.
//

import Foundation

// MARK: - RequestResponse
struct RequestResponse: Codable {
    let success: Bool
    let message: String
    let data: RegResponse
}

// MARK: - DataClass
struct RegResponse: Codable {
    let id, userID, type: String
    let amount: Double
    let currency: String
    let status: Int
    let toUserID, toUserName, toUserEmail: String
    let createdAt: String
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case type, amount, currency, status
        case toUserID = "toUserId"
        case toUserName, toUserEmail, createdAt, updatedAt
    }
}
