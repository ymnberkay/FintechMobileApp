//
//  ReceiveAmountView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 4.09.2025.
//

import SwiftUI

struct ReceiveAmountView: View {
    @StateObject var viewModel: ReceiveAmountViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack(spacing: 16) {
            headerView
            VStack(spacing: 16) {
                
                userProfileView
                    .padding()
                
                amountInputView
                
                continueButtonView
                
                Spacer()
            }
            .padding(.vertical, 20)
            .background(RoundedRectangle(cornerRadius: 20.0).foregroundColor(ColorPalette.bgLight))
            .padding(.horizontal, 24)
        }
        .background(ColorPalette.gray100)
        .navigationBarHidden(true)
        
        .alert("Bilgi", isPresented: $viewModel.showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
                .font(Typography.bodyMediumRegular)
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 16) {
            BackButton {
                coordinator.pop()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Enter Amount")
                    .font(Typography.bodyLargeBold)
                    .foregroundColor(ColorPalette.black)
                
                Text("Please enter an amount to get paid")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(ColorPalette.gray100)
        
    }
    
    // MARK: - User Profile View
    private var userProfileView: some View {
        VStack(spacing: 16) {
            // Avatar
            if let avatarImageName = viewModel.model.toUserName {
                Image(systemName: avatarImageName)
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(ColorPalette.contentTertiary)
                    .frame(width: 80, height: 80)
                    .background(ColorPalette.gray200)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(ColorPalette.gray200)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(ColorPalette.contentTertiary)
                    )
            }
            
            // User Info
            VStack(spacing: 4) {
                Text(viewModel.model.toUserName ?? "unknown")
                    .font(Typography.headlineLargeSemibold)
                    .foregroundColor(ColorPalette.contentPrimary)
                
                Text(viewModel.model.toUserEmail ?? "unknown")
                    .font(Typography.bodySmallRegular)
                    .foregroundColor(ColorPalette.contentSecondary)
            }
        }
    }
    
    // MARK: - Amount Input View
    private var amountInputView: some View {
        VStack(spacing: 16) {
            // Currency Symbol
            HStack {
                Spacer()
                Image("Country=US")
                    .resizable()
                    .frame(width: 24, height: 24)
                Spacer()
            }
            
            // Amount TextField
            VStack(spacing: 8) {
                TextField("$0", text: $viewModel.amount)
                    .font(Typography.titleLargeBold)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .foregroundColor(ColorPalette.contentPrimary)
                    .onChange(of: viewModel.amount) { newValue in
                        viewModel.updateAmount(newValue)
                    }
                
            }
            Divider()
                .background(ColorPalette.black)
        }
        .frame(maxWidth: 250)
    }
    
    // MARK: - Continue Button View
    private var continueButtonView: some View {
        Button(action: {
            viewModel.continueAction()
            if viewModel.isValidAmount {
                viewModel.pickAmount()
                coordinator.push(.ReceiveSummary)
            }
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.contentOnColor))
                        .scaleEffect(0.8)
                } else {
                    Text("Continue")
                        .font(Typography.labelLargeSemibold)
                }
            }
            .foregroundColor(ColorPalette.contentOnColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                viewModel.isValidAmount && !viewModel.isLoading
                ? ColorPalette.primary
                : ColorPalette.contentDisabled
            )
            .cornerRadius(16)
        }
        .disabled(!viewModel.isValidAmount || viewModel.isLoading)
        .animation(.easeInOut(duration: 0.2), value: viewModel.isValidAmount)
        .padding(.horizontal, 24)
    }
}

#Preview {
    ReceiveAmountView(viewModel: ReceiveAmountViewModel(model: TransferModel()))
}
