//
//  LoginViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 13.06.2025.
//
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
    @Published var loginIsSuccess: Bool = false
    @Published var userID: String = ""
    @Published var isLoading: Bool = false
    
    
    
    func postLogin(phoneNumber: String, password: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        defer { DispatchQueue.main.async { self.isLoading = false } }
        
        let model = LoginRequest(phoneNumber: phoneNumber, password: password)
        if let response = await NetworkManager.networkManager.post(
            path: .Login,
            model: model,
            type: LoginResponse.self
        ) {
            print(response)
            self.loginIsSuccess = response.success
            self.userID = response.userId ?? ""
        } else {
            self.loginIsSuccess = false
        }
    }
}
