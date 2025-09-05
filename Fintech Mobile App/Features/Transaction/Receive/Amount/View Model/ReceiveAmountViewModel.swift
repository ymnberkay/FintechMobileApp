//
//  ReceiveAmountViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.09.2025.
//
import SwiftUI

final class ReceiveAmountViewModel: ObservableObject {
    @ObservedObject var model: TransferModel
    @Published var amount: String = "500.0"
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false

    
    var isValidAmount: Bool {
        guard let amountValue = Double(amount), amountValue > 0 else {
            return false
        }
        return true
    }
    
    init(model: TransferModel) {
        self.model = model
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
    
    func pickAmount() {
        model.amount = Double(amount) ?? 0.0
    }
}
