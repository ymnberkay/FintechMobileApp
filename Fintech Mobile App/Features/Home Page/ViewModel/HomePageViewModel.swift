//
//  HomePageViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 1.06.2025.
//

import Foundation


final class HomePageViewModel: ObservableObject {
    @Published var searchableObject: String = ""
    @Published var balance: Double = 0.0
    @Published var currency: String = ""
    @Published var lastUpdate: String = ""
    @Published var message: String = ""
    
    
    
    func getBalanceData(userId: String) async {
        print(userId)
        let balancePath = NetworkPath.GetBalance(userId: userId)
        if let response = await NetworkManager.networkManager.get(path: balancePath, type: BalanceResponse.self) {
            self.balance = response.balance
            self.currency = response.currency
            self.lastUpdate = response.lastUpdated
        } else {
            self.message = "Error"
        }
    }
}
