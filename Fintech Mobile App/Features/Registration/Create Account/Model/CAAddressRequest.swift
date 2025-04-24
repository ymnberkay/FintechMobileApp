//
//  CAAddressRequest.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//

struct CAAddressRequest: Codable {
    var id: String
    var addressLine: String
    var city: String
    var postCode: String
}
