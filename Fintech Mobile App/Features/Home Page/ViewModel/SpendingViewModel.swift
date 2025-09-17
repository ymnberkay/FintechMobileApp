//
//  SpendingViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.07.2025.
//
import Foundation
import SwiftUI

final class SpendingViewModel: ObservableObject {
    @Published var selectedMonth = "January"
    @Published var avaibleBalance: Double = 0.0
    @Published var totalSpend: Double = 0.0
    
    static let monthsSpending = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"]
    
    let data: [WeeklyData] = [
            WeeklyData(weekRange: "2-8", amount: 100, color: Color.blue),
            WeeklyData(weekRange: "9-15", amount: 50, color: Color.yellow),
            WeeklyData(weekRange: "16-22", amount: 100, color: Color.blue),
            WeeklyData(weekRange: "23-29", amount: 25, color: Color.yellow),
            WeeklyData(weekRange: "30-1", amount: 75, color: Color.blue)
        ]
    
    
    
    
    
}



