//
//  SettingViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 10.09.2025.
//

import Foundation
import SwiftUI

struct SettingsItem {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let iconBackground: Color
    let title: String
    let type: SettingsItemType
}

enum SettingsItemType {
    case toggle(binding: Binding<Bool>)
    case navigation(action: () -> Void)
}

final class SettingViewModel: ObservableObject {
    @Published var isDarkMode = false
    
    var settingsItems: [SettingsItem] {
        [
            SettingsItem(
                icon: "person.fill",
                iconColor: .blue,
                iconBackground: Color.blue.opacity(0.2),
                title: "Personal Info",
                type: .navigation { [weak self] in
                    self?.navigateToPersonalInfo()
                }
            ),
            SettingsItem(
                icon: "building.columns.fill",
                iconColor: .orange,
                iconBackground: Color.orange.opacity(0.2),
                title: "Bank & Cards",
                type: .navigation { [weak self] in
                    self?.navigateToBankCards()
                }
            ),
            SettingsItem(
                icon: "creditcard.fill",
                iconColor: .red,
                iconBackground: Color.red.opacity(0.2),
                title: "Transaction",
                type: .navigation { [weak self] in
                    self?.navigateToTransaction()
                }
            ),
            SettingsItem(
                icon: "gearshape.fill",
                iconColor: .blue,
                iconBackground: Color.blue.opacity(0.2),
                title: "Settings",
                type: .navigation { [weak self] in
                    self?.navigateToSettings()
                }
            ),
            SettingsItem(
                icon: "server.rack",
                iconColor: .green,
                iconBackground: Color.green.opacity(0.2),
                title: "Data Privacy",
                type: .navigation { [weak self] in
                    self?.navigateToDataPrivacy()
                }
            )
        ]
    }
    
    // MARK: - Navigation Actions
    func navigateToPersonalInfo() {
        print("Navigate to Personal Info")
    }
    
    func navigateToBankCards() {
        print("Navigate to Bank & Cards")
    }
    
    func navigateToTransaction() {
        print("Navigate to Transaction")
    }
    
    func navigateToSettings() {
        print("Navigate to Settings")
    }
    
    func navigateToDataPrivacy() {
        print("Navigate to Data Privacy")
    }
    
    // MARK: - Dark Mode Actions
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
}
