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
    @StateObject var chooseRecipientViewModel: ChooseRecipientViewModel
    @StateObject var recievePurposeViewModel: ReceivePurposeViewModel
    @StateObject var receiveAmountViewModel: ReceiveAmountViewModel
    @StateObject var receiveSummaryViewModel: ReceiveSummaryViewModel
    
    
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
                    case .ReceiveChooseRecipent:
                        ChooseRecipientView(viewModel: chooseRecipientViewModel)
                            .environmentObject(userManager)
                    case .ReceiveChoosePurpose:
                        RecievePurposeView(viewModel: recievePurposeViewModel)
                    case .ReceiveAmount:
                        ReceiveAmountView(viewModel: receiveAmountViewModel)
                    case .ReceiveSummary:
                        ReceiveSummaryView(viewModel: receiveSummaryViewModel)
                    }
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    RootView(createAccountViewModel: CAViewModel(), loginViewModel: LoginViewModel(), homePageViewModel: HomePageViewModel(), spendingViewModel: SpendingViewModel(),transactionViewModel: TransactionViewModel(), chooseRecipientViewModel: ChooseRecipientViewModel(model: TransferModel()), recievePurposeViewModel: ReceivePurposeViewModel(model: TransferModel()),receiveAmountViewModel: ReceiveAmountViewModel(model: TransferModel()),receiveSummaryViewModel: ReceiveSummaryViewModel(model: TransferModel()))
}
