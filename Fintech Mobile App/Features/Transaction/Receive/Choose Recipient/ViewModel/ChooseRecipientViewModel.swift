//
//  ChooseRecipientViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.08.2025.
//
import Foundation
import Combine
import SwiftUI

struct Request {
    let id = UUID()
    let name: String
    let email: String
    let amount: Double
}

final class ChooseRecipientViewModel: ObservableObject {
    @ObservedObject var model: TransferModel
    @Published var selectedReciever: User? = User(id: "")
    @Published var searchText: String = ""
    @Published var recentTransactions: [Transaction] = []
    @Published var isSuccess: Bool = false
    @Published var requests: [RequestsResponse] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(model: TransferModel) {
        self.model = model
        setupSearchDebounce()
    }
    
    var isEmailEntered: Bool {
        !searchText.isEmpty && searchText.contains("@") && searchText.contains("gmail.com")
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
    
    func getUserTransactionRequest(userId: String) async {
        let path = NetworkPath.GetUserRequests(userId: userId)
        if let response = await NetworkManager.networkManager.get(
            path: path,
            type: GetRequestReponse.self) {
            await MainActor.run {
                print(response.data)
                if response.success {
                    self.requests = response.data
                }
            }
        }
    }
    
    func handleMoneyRequest(userRequestId: String, approve: Bool) async {
        let model = MoneyRequestApproval(requestID: userRequestId ,approve: approve)
        if let response = await NetworkManager.networkManager.put(
            path: NetworkPath.HandleMoneyRequest,
            model: model,
            type: HandleMoneyRequestReponse.self) {
            await MainActor.run {
                if response.success {
                    print("\(userRequestId) adlı kullanıcı \(approve ? "Onayladı": "Reddetti")")
                    self.requests.removeAll { $0.id == userRequestId }
                }
            }
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
