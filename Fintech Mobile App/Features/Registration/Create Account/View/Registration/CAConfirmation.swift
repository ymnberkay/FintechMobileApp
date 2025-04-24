//
//  CAConformation.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//

import SwiftUI

struct CAConfirmation: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject var viewModel: CAViewModel
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Confirm Your Phone")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.headlineLargeSemibold)
                Text("We send 6 digits code to \(viewModel.selectedCountry?.code) \(viewModel.phoneNumberText)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.bodyMediumRegular).opacity(0.7)
            }
            .padding(.vertical)
            
            OTPTextField(enterValue: $viewModel.enterValue)
                .padding()
            
            Text("Didn't get a code? **Resend**")
            
            Spacer()
            
            Button {
                if viewModel.otpCompare(enterValue: viewModel.enterValue) {
                    coordinator.push(.caCountry)
                }
            } label: {
                Text("Verify Your Number")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }
            .padding()
        }
    }
}

#Preview {
    CAConfirmation(viewModel: CAViewModel())
}
