//
//  GetRequestResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.09.2025.
//

import Foundation

// MARK: - GetRequestReponse
import Foundation

// MARK: - GetRequestReponse
struct GetRequestReponse: Codable {
    let success: Bool
    let message: String
    let data: [RequestsResponse]
}

// MARK: - Datum
struct RequestsResponse: Codable {
    let id, receiverUserID, type: String
    let amount: Double
    let currency, senderUserID, senderUserName, senderUserEmail: String

    enum CodingKeys: String, CodingKey {
        case id
        case receiverUserID = "receiverUserId"
        case type, amount, currency
        case senderUserID = "senderUserId"
        case senderUserName, senderUserEmail
    }
}
