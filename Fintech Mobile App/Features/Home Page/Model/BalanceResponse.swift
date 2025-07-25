//
//  BalanceResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 30.06.2025.
//

struct BalanceResponse: Codable {
    let userId: String
    let balance: Double
    let currency: String
    let lastUpdated: String
}
