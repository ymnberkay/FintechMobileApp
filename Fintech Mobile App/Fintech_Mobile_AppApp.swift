//
//  Fintech_Mobile_AppApp.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//

import SwiftUI
import Firebase

@main
struct Fintech_Mobile_AppApp: App {
    
    @StateObject private var coordinator = NavigationCoordinator()
    @StateObject private var userManager = UserManager()
    @StateObject var createAccountViewModel = CAViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var homePageViewModel = HomePageViewModel()
    @StateObject var spendingViewModel = SpendingViewModel()
    @StateObject var recipientViewModel = TransactionViewModel()
    
    @StateObject private var receiveTransferModel: TransferModel
    @StateObject private var chooseRecipientViewModel: ChooseRecipientViewModel
    @StateObject private var receivePurposeViewModel: ReceivePurposeViewModel
    @StateObject private var receiveAmountViewModel: ReceiveAmountViewModel
    @StateObject private var receiveSummaryViewModel: ReceiveSummaryViewModel
    
    init() {
        FirebaseApp.configure()
        let transferModel = TransferModel()
        
        // Request view flow
        _receiveTransferModel = StateObject(wrappedValue: transferModel)
        _chooseRecipientViewModel = StateObject(wrappedValue: ChooseRecipientViewModel(model: transferModel))
        _receivePurposeViewModel = StateObject(wrappedValue: ReceivePurposeViewModel(model: transferModel))
        _receiveAmountViewModel = StateObject(wrappedValue: ReceiveAmountViewModel(model: transferModel))
        _receiveSummaryViewModel = StateObject(wrappedValue: ReceiveSummaryViewModel(model: transferModel))
        
    }
    var body: some Scene {
        WindowGroup {
            RootView(createAccountViewModel: createAccountViewModel, loginViewModel: loginViewModel, homePageViewModel: homePageViewModel, spendingViewModel: spendingViewModel, transactionViewModel: recipientViewModel, chooseRecipientViewModel: chooseRecipientViewModel, recievePurposeViewModel: receivePurposeViewModel, receiveAmountViewModel: receiveAmountViewModel, receiveSummaryViewModel: receiveSummaryViewModel)
                .environmentObject(userManager)
                .environmentObject(coordinator)
        }
    }
}
