//
//  DateFormatter+DateFormat.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//
import Foundation

extension DateFormatter {
    static var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
}
