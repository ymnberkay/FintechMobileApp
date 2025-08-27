//
//  CreateTransactionResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 27.08.2025.
//

import Foundation

// MARK: - CreateTransacitonResponse
struct CreateTransacitonResponse: Codable {
    let success: Bool
    let message: String
    let data: TransacitonResponse
}

// MARK: - DataClass
struct TransacitonResponse: Codable {
    let id, userID, type: String
    let amount: Double
    let currency: String
    let status: Int
    let toUserID, toUserName, toUserEmail: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case type, amount, currency, status
        case toUserID = "toUserId"
        case toUserName, toUserEmail, createdAt
    }
}
