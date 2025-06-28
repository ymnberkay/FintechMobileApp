//
//  Residence.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//

struct CAResidenceRequest: Codable {
    let userID, residence: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case residence
    }
}
