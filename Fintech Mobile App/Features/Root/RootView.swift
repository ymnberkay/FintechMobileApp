//
//  RootView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 14.04.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = NavigationCoordinator()
    @StateObject var createAccountViewModel: CAViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            EntryView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .login:
                        SplashView()
                    case .signUp:
                        CAPhoneNumber(viewModel: createAccountViewModel)
                    case .caConfirmPhone:
                        CAConfirmation(viewModel: createAccountViewModel)
                    case .caCountry:
                        CACountry(viewModel: createAccountViewModel)
                    case .caName:
                        CAName(viewModel: createAccountViewModel)
                    case .caAdress:
                        CAAddress(viewModel: createAccountViewModel)
                    case .caEmail:
                        CAEmail(viewModel: createAccountViewModel)
                    case .caPasscode:
                        CAPasscode(viewModel: createAccountViewModel)
                    case .welcome:
                        Welcome()
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    RootView(createAccountViewModel: CAViewModel())
}
