//
//  WeeklyData.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 13.07.2025.
//

import Foundation
import SwiftUI

struct WeeklyData: Identifiable {
    let id = UUID()
    let weekRange: String
    let amount: Double
    let color: Color
}
