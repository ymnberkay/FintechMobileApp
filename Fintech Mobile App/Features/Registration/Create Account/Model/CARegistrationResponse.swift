//
//  CARegistrationResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.05.2025.
//

import Foundation

// MARK: - Welcome
struct CARegistrationResponse: Codable {
    
    let success: Bool
    let message: String
    let userId: String?
    let phoneNumber: String?
    let token: String?
    let createDate: String?
    
}
