//
//  SendViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.08.2025.
//

import Foundation
import Combine

final class TransactionViewModel: ObservableObject {
    @Published var recentTransactions: [Transaction] = []
    @Published var selectedReciever: User? = User(id: "")
    @Published var searchText: String = ""
    @Published var isSuccess: Bool = false
    @Published var selectedPurpose: TransferPurpose?
    @Published var purposes: [TransferPurpose] = TransferPurposeType.allCases.map { $0.purpose }
    
    @Published var amount: String = "500.0"
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var transactionIsComplete: Bool = false
    @Published var createdTransaction: TransacitonResponse = TransacitonResponse(id: "", userID: "", type: "", amount: 0.0, currency: "", status: 0, toUserID: "", toUserName: "", toUserEmail: "", createdAt: "")
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        selectedPurpose = TransferPurposeType.personal.purpose
        setupSearchDebounce()
    }
    
    
    var isEmailEntered: Bool {
        !searchText.isEmpty && searchText.contains("@") && searchText.contains("gmail.com")
    }
    
    var isValidAmount: Bool {
        guard let amountValue = Double(amount), amountValue > 0 else {
            return false
        }
        return true
    }
    
    var formattedAmount: String {
        return amount.isEmpty ? "0" : amount
    }
    
    // get user recent transactions
    func getUserTransaction(userID: String) async {
        let path = NetworkPath.GetUserTransactions(userId: userID)
        if let response = await NetworkManager.networkManager.get(
            path: path,
            type: GetUserTransactionResponse.self) {
            await MainActor.run {
                if response.success {
                    self.recentTransactions = response.data ?? []
                    self.isSuccess = response.success
                } else {
                    self.recentTransactions = []
                }
            }
        }
    }
    
    // find user info by email
    func getUserInfoByEmail(email: String) async {
        let path = NetworkPath.PIFetchFullDataByEmail(email: email)
        if let response = await NetworkManager.networkManager.get(
            path: path,
            type: PersonalInfo.self) {
            await MainActor.run {
                if response.success {
                    self.selectedReciever = response.data
                }
            }
        }
    }
    
    // create transaction
    func postCreateTransaction(id: String) async {
        let model = CreateTransacitonModel(userID: id, type: selectedPurpose?.title ?? "", amount: Double(amount) ?? 0.0, currency: "USD", toUserID: selectedReciever?.id ?? "", toUserName: selectedReciever?.fullName ?? "", toUserEmail: selectedReciever?.email ?? "")
        if let response = await NetworkManager.networkManager.post(
            path: .CreateTransaction,
            model: model,
            type: CreateTransacitonResponse.self) {
            await MainActor.run {
                if response.success {
                    self.transactionIsComplete = true
                    self.createdTransaction = response.data
                }
            }
        }
    }
    
    func scanToPay() {
        
    }
    
    func selectPurpose(_ purpose: TransferPurpose) {
        selectedPurpose = purpose
    }
    
    func updateAmount(_ newAmount: String) {
        let filtered = newAmount.filter { $0.isNumber }
        self.amount = filtered
    }
    
    func continueAction() {
        guard isValidAmount else {
            self.alertMessage = "Please enter valid value."
            self.showAlert = true
            return
        }
    }
    
    
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink { [weak self] email in
                guard let self = self else { return }
                guard self.isEmailEntered else { return }
                Task {
                    await self.getUserInfoByEmail(email: email)
                }
            }
            .store(in: &cancellables)
    }
    
}
