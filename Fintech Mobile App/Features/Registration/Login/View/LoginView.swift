//
//  LoginView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.05.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject var caViewModel: CAViewModel
    @StateObject var viewModel: LoginViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack {
                    Text("Login to Coinpay")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.headlineLargeSemibold)
                    Text("Enter your registered mobile number to log in.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.bodyMediumRegular).opacity(0.7)
                }
                Phone(selectedCountry: $caViewModel.selectedCountry, text: $viewModel.phoneNumber)
                Password(text: $viewModel.password)
                Spacer()
                Button {
                    if viewModel.password != "" && viewModel.phoneNumber != "" {
                        Task {
                            await viewModel.postLogin(phoneNumber: "\((caViewModel.selectedCountry?.code ?? "") + viewModel.phoneNumber)", password: viewModel.password)
                            if viewModel.loginIsSuccess {
                                coordinator.push(.home)
                            }
                        }
                    }
                    
                } label: {
                    Text("Login")
                        .font(Typography.bodyLargeSemibold)
                        .foregroundColor(ColorPalette.bgLight)
                        .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
                }.padding()
            }
        }
        
    }
}

#Preview {
    EntryView()
}

