//
//  RootView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 14.04.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject var createAccountViewModel: CAViewModel
    @StateObject var loginViewModel: LoginViewModel
    @StateObject var homePageViewModel: HomePageViewModel
    @StateObject var spendingViewModel: SpendingViewModel
    @StateObject var transactionViewModel: TransactionViewModel
    @EnvironmentObject var userManager: UserManager
    
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            EntryView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .login:
                        LoginView(caViewModel: createAccountViewModel, viewModel: loginViewModel)
                            .environmentObject(userManager)
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
                    case .home:
                        DashbordView(homePageViewModel: homePageViewModel, spendingViewModel: spendingViewModel)
                            .environmentObject(userManager)
                    case .recipient:
                        RecipientView(viewModel: transactionViewModel)
                            .environmentObject(userManager)
                    case .purpose:
                        SelectPurposeView(viewModel: transactionViewModel)
                    case .amount:
                        AmountView(viewModel: transactionViewModel)
                    case .accountSelect:
                        AccountSelectView(viewModel: transactionViewModel)
                            .environmentObject(userManager)
                    case .transactionSummary:
                        TransactionSummaryView(viewModel: transactionViewModel)
                            .environmentObject(userManager)
                        
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    RootView(createAccountViewModel: CAViewModel(), loginViewModel: LoginViewModel(), homePageViewModel: HomePageViewModel(), spendingViewModel: SpendingViewModel(),transactionViewModel: TransactionViewModel())
}
