//
//  Transaction.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.08.2025.
//

struct Transaction: Codable, Identifiable {
    let id: String
    let userId: String
    let type: String
    let amount: Double
    let currency: String
    let status: Int
    let toUserId: String
    let toUserName: String
    let toUserEmail: String
    let createdAt: String
}
