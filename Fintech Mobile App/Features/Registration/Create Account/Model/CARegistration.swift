//
//  CARegistration.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.05.2025.
//

import Foundation

struct CARegistrationRequest: Codable {
    let phoneNumber: String
    let password: String
    let createDate: Date
}

