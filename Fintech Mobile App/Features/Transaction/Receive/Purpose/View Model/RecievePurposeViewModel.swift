//
//  RecieveViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 4.09.2025.
//

import Foundation
import SwiftUI

final class ReceivePurposeViewModel: ObservableObject {
    @ObservedObject var model: TransferModel
    @Published var selectedPurpose: TransferPurpose?
    @Published var purposes: [TransferPurpose] = ReceiveTransferPurposeType.allCases.map { $0.purpose }
    
    init(model: TransferModel) {
        self.model = model
        selectedPurpose = ReceiveTransferPurposeType.personal.purpose
        
    }
    
    func selectPurpose(_ purpose: TransferPurpose) {
        selectedPurpose = purpose
        model.type = purpose.title
    }
    func updateTransferModel() {
        model.type = "MoneyRequest"
    }
}
