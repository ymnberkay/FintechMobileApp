//
//  CreateTransacitonModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 27.08.2025.
//

import Foundation

// MARK: - CreateTransacitonModel
struct CreateTransacitonModel: Codable {
    let userID, type: String
    let amount: Double
    let currency, toUserID, toUserName, toUserEmail: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case type, amount, currency
        case toUserID = "toUserId"
        case toUserName, toUserEmail
    }
}
