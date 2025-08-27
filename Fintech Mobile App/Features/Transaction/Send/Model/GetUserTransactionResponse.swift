//
//  GetUserTransactionResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.08.2025.
//

struct GetUserTransactionResponse: Codable {
    let success: Bool
    let message: String
    let data: [Transaction]?
}
