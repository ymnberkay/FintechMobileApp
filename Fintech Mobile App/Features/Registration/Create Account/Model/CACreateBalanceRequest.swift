//
//  CACreateBalanceRequest.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 7.07.2025.
//

import Foundation


struct CABalanceRequest: Codable {
    
    var userId: String
    var balance: Double
    var currency: String
    
}
