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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        selectedPurpose = TransferPurposeType.personal.purpose
        setupSearchDebounce()
    }
    
    var isEmailEntered: Bool {
        !searchText.isEmpty && searchText.contains("@") && searchText.contains("gmail.com")
    }
    
    
    // get user recent transactions
    func getUserTransaction(userID: String) async {
        let path = NetworkPath.GetUserTransactions(userId: userID)
        if let response = await NetworkManager.networkManager.get(path: path, type: GetUserTransactionResponse.self) {
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
        if let response = await NetworkManager.networkManager.get(path: path, type: PersonalInfo.self) {
            await MainActor.run {
                if response.success {
                    self.selectedReciever = response.data
                }
            }
        }
    }
    
    func scanToPay() {
        
    }
    
    func selectPurpose(_ purpose: TransferPurpose) {
        selectedPurpose = purpose
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
