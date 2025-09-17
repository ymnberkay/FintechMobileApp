//
//  HandleMoneyRequestReponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 16.09.2025.
//

struct HandleMoneyRequestReponse: Codable {
    let success: Bool
    let message: String
    let transaction: MoneyRequest?
}

struct MoneyRequest: Codable, Identifiable {
    let id: String?
    let userId: String
    let type: String
    let amount: Double
    let currency: String
    let status: String
    let toUserId: String?
    let toUserName: String?
    let toUserEmail: String?
    let createdAt: String
    let updatedAt: String?
}
