//
//  TransferRequestDTO.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.09.2025.
//

struct TransferRequestDTO: Encodable {
    let userId: String
    let type: String
    let amount: Double
    let currency: String
    let toUserId: String?
    let toUserName: String?
    let toUserEmail: String?
    
    init(from model: TransferModel) {
        self.userId = model.userId
        self.type = model.type
        self.amount = model.amount
        self.currency = model.currency
        self.toUserId = model.toUserId
        self.toUserName = model.toUserName
        self.toUserEmail = model.toUserEmail
    }
}
