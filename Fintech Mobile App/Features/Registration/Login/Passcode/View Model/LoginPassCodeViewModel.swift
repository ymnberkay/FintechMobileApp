//
//  LoginPassCodeViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

import Foundation

final class LoginPassCodeViewModel: ObservableObject {
    @Published var passcode: String = ""
    @Published var currentUser: PasscodeUser?
    @Published var isLoading: Bool = false
    @Published var loginIsSuccess: Bool = false
    
    func postLogin(phoneNumber: String, passcode: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        defer { DispatchQueue.main.async { self.isLoading = false } }
        
        let model = LoginPasscodeRequest(phoneNumber: phoneNumber, passcode: passcode)
        if let response = await NetworkManager.networkManager.post(
            path: .LoginPasscode,
            model: model,
            type: LoginResponse.self
        ) {
            print(response)
            self.loginIsSuccess = response.success
        } else {
            self.loginIsSuccess = false
        }
    }
}
