//
//  ReceiveSummaryViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.09.2025.
//

import SwiftUI

final class ReceiveSummaryViewModel: ObservableObject {
    @ObservedObject var model: TransferModel
    @Published var requestIsComplete: Bool = false
    
    init(model: TransferModel) {
        self.model = model
    }
    
    
    func postRequestMoney() async {
        let dto = TransferRequestDTO(from: model)
        if let response = await NetworkManager.networkManager.post(
            path: .RequestMoney,
            model: dto,
            type: RequestResponse.self) {
            await MainActor.run {
                if response.success {
                    requestIsComplete = true
                }
            }
        }
    }
    
}
