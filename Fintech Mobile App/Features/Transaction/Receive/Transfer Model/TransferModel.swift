//
//  TransferModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.08.2025.
//

import Foundation

final class TransferModel: ObservableObject {
    @Published var userId: String = ""
    @Published var type: String = ""
    @Published var amount: Double = 0.0
    @Published var currency: String = "USD"
    
    // Alıcı bilgileri
    @Published var toUserId: String?
    @Published var toUserName: String?
    @Published var toUserEmail: String?
    
    // Opsiyonel: reset fonksiyonu
    func reset() {
        userId = ""
        type = ""
        amount = 0.0
        currency = "USD"
        toUserId = nil
        toUserName = nil
        toUserEmail = nil
    }
}
