//
//  SendViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.08.2025.
//

import Foundation
import Combine

final class RecipientViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var recipients: [Recipient] = []
    @Published var filteredReceivers: [ReceiverUser] = []
    @Published var receivers: [ReceiverUser] = []
    @Published var selectedReceiver: ReceiverUser?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var isEmailEntered: Bool {
        !searchText.isEmpty && searchText.contains("@") && searchText.contains("gmail.com")
    }
    
    init() {
        loadRecipients()
        setupSearch()
    }
    
    // MARK: - Public Methods
    func loadRecipients() {
        isLoading = true
        
        // Simulating API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.recipients = [
                Recipient(name: "Berkay Yaman", email: "helloyouberkay@gmail.com", amount: "-$10000"),
                Recipient(name: "Cenkay Yaman", email: "helloyoucenkay@gmail.com", amount: "-$23200"),
                Recipient(name: "Mehedi Hasan", email: "helloyouthmed@gmail.com", amount: "-$100"),
                Recipient(name: "Mehedi Hasan", email: "helloyouthmed@gmail.com", amount: "-$100"),
                Recipient(name: "Mehedi Hasan", email: "helloyouthmed@gmail.com", amount: "-$100")
            ]
            self.filteredReceivers = self.receivers
            self.isLoading = false
        }
    }
    
    func selectReciever(_ receiver: ReceiverUser) {
        selectedReceiver = receiver
        searchText = receiver.email
        print("Selected recipient: \(receiver.fullName)")
    }
    
    func selectFromSearch() {
        if isSuccess {
            // Create a new recipient from search text
            let newReceiver = ReceiverUser(id: "1", residence: "non", fullName: "Unknown", userName: "non", dateOfBirth: "non", addressLine: "non", city: "non", postCode: "non", email: "non")
            selectedReceiver = newReceiver
            print("Selected recipient from search: \(searchText)")
        }
    }
    
    func proceedWithSelectedRecipient() {
        guard let receiver = selectedReceiver else { return }
        
    }
    
    func getUserDetailsByEmail(email: String) async {
        if isEmailEntered {
            
            let fetchFullDataByEmailPath = NetworkPath.PIFetchFullDataByEmail(email: email)
            if let response = await NetworkManager.networkManager.get(path: fetchFullDataByEmailPath, type: UserDataByEmailResponse.self) {
                await MainActor.run {
                    self.selectedReceiver = response.data
                    self.isSuccess = response.success
                    print(response)
                }
                
            } else {
                
            }
            
        }
    }
    
    
    func scanToPay() {
        // Handle scan to pay logic
        print("Scan to pay tapped")
    }
    
    // MARK: - Private Methods
    private func setupSearch() {
        $searchText
                    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                    .removeDuplicates()
                    .sink { [weak self] searchText in
                        guard let self = self else { return }
                        
                        // 1️⃣ Önce filtreleme yap
                        self.filterReceivers(with: searchText)
                        
                        // 2️⃣ Eğer e-posta formatı uygunsa API çağrısı yap
                        if self.isEmailEntered {
                            Task {
                                await self.getUserDetailsByEmail(email: searchText)
                                await MainActor.run {
                                    self.selectFromSearch()
                                }
                            }
                        }
                    }
                    .store(in: &cancellables)
    }
    
    private func filterReceivers(with searchText: String) {
        if searchText.isEmpty {
            filteredReceivers = receivers
            selectedReceiver = nil
        } else {
            filteredReceivers = receivers.filter { receiver in
                receiver.fullName.localizedCaseInsensitiveContains(searchText) ||
                receiver.email.localizedCaseInsensitiveContains(searchText)
            }
            
            // Auto-select if email matches exactly
            if let exactMatch = receivers.first(where: { $0.email.lowercased() == searchText.lowercased() }) {
                selectedReceiver = exactMatch
            } else if isEmailEntered {
                selectedReceiver = ReceiverUser(id: "1", residence: "non", fullName: "Unknown", userName: "non", dateOfBirth: "non", addressLine: "non", city: "non", postCode: "non", email: "non")
            }
        }
    }
}
