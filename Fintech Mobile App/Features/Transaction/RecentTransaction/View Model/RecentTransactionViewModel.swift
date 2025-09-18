//
//  RecentTransactionViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.09.2025.
//

import Foundation

final class RecentTransactionViewModel: ObservableObject {
    @Published var recentTransactions: [Transaction] = []
    @Published var isSuccess: Bool = false
    
    
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
}
