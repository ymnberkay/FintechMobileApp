//
//  LoginResponse.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.06.2025.
//
import Foundation

struct LoginResponse: Codable {
    
    let success: Bool
    let message: String
    let userId: String?
    let phoneNumber: String?
    let token: String?
    let createDate: String?
    
}
