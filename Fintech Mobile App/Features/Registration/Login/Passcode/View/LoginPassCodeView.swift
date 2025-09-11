//
//  LoginPassCodeView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

import SwiftUI

struct LoginPassCodeView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel = LoginPassCodeViewModel()
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 16) {
                    VStack {
                        Text("Login to Coinpay")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .font(Typography.headlineLargeSemibold)
                        Text("Enter your passcode to log in.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .font(Typography.bodyMediumRegular).opacity(0.7)
                    }
                    PersonalInfoView(name: viewModel.currentUser?.name ?? "Berkay Yaman", email: viewModel.currentUser?.email ?? "ymnberkayy@gmail.com", id: viewModel.currentUser?.id ?? "123123", width: geo.size.width - 30, circleSize: geo.size.width * 0.2)
                    SecureField("Enter Passcode", text: $viewModel.passcode)
                        .font(Typography.labelLargeRegular)
                        .autocorrectionDisabled()
                        .keyboardType(.numberPad)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                                .frame(height: 55)
                        )
                        .padding()
                        .onChange(of: viewModel.passcode) { oldValue, newValue in
                            if viewModel.passcode.count >= 5 {
                                viewModel.passcode = oldValue
                                print(viewModel.passcode)
                            }
                        }
                    OneTextButton(title: "Use Password") {
                        coordinator.push(.login)
                    }
                    OneTextButton(title: "Log in") {
                        if viewModel.passcode != "" {
                            Task {
                                await viewModel.postLogin(phoneNumber: viewModel.currentUser?.phoneNumber ?? "", passcode: viewModel.passcode)
                                if viewModel.loginIsSuccess {
                                    userManager.setUserID(viewModel.currentUser?.id ?? "")
                                    Task {
                                        try? await Task.sleep(nanoseconds: 200_000_000) // 0.2 saniye
                                        coordinator.push(.home)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                }
                if viewModel.isLoading {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    ProgressView("Logging in...")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                }
            }
            .onAppear {
                viewModel.currentUser = SwiftDataManager.shared.currentUser
            }
            .navigationBarHidden(true)
        }
        
    }
}

#Preview {
    LoginPassCodeView()
}

private struct PersonalInfoView: View {
    let name: String
    let email: String
    let id: String
    let width: Double
    let circleSize: Double
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: circleSize, height: circleSize)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(ColorPalette.black, lineWidth: 2) // kenarlık
                )
            Text("Welcome \(name) :)")
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.black)
            Text(email)
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.black)
            
        }
        .padding(.all)
        .background(RoundedRectangle(cornerRadius: 20).fill(ColorPalette.bgLight).frame(width: width))
    }
}
