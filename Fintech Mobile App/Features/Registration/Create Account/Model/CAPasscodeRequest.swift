//
//  CAPasscodeRequest.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 24.04.2025.
//

struct CAPasscodeRequest: Codable {
    var id: String
    var passcode: String
    var isCompleted: Bool
}
