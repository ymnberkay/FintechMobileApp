//
//  CreateAccountPhoneNumber.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//

import SwiftUI

struct CAPhoneNumber: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject var viewModel: CAViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack {
                    Text("Create An Account")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.headlineLargeSemibold)
                    Text("Enter your mobile number to verify your account.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.bodyMediumRegular).opacity(0.7)
                }
                Phone(selectedCountry: $viewModel.selectedCountry, text: $viewModel.phoneNumberText)
                Password(text: $viewModel.password)
                Spacer()
                Button {
                    if viewModel.password != "" && viewModel.phoneNumberText != "" {
                        Task {
                            print("\((viewModel.selectedCountry?.code ?? "") + viewModel.phoneNumberText)")
                            await                         viewModel.registration(phoneNumber: "\((viewModel.selectedCountry?.code ?? "") + viewModel.phoneNumberText)", password: viewModel.password)
                            if viewModel.success {
                                viewModel.showCorrectAllert = true
                            }
                        }
                        
                        
                    }
                } label: {
                    Text("Sign Up")
                        .font(Typography.bodyLargeSemibold)
                        .foregroundColor(ColorPalette.bgLight)
                        .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                        
                }.padding()
            }
            if viewModel.showCorrectAllert {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                AlertCorrect(phoneNumber: viewModel.phoneNumberText, countryCode: viewModel.selectedCountry?.code ?? "", onConfirm: {coordinator.push(.caConfirmPhone)}, onCancel: {viewModel.showCorrectAllert = false})
            }
        }.onAppear {
            viewModel.success = false
        }
        .animation(.easeInOut, value: viewModel.showCorrectAllert)

    }
}

#Preview {
    CAPhoneNumber(viewModel: CAViewModel())
}
