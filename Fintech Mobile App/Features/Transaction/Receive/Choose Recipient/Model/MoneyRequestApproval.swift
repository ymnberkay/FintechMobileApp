//
//  MoneyRequestApproval.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 16.09.2025.
//

struct MoneyRequestApproval: Codable {
    let requestID: String
    let approve: Bool
    
    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case approve
    }
}
