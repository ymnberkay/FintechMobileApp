//
//  Item.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
