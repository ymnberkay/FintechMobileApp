//
//  CAPasscode.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 24.04.2025.
//

import SwiftUI

struct CAPasscode: View {
    @StateObject var viewModel: CAViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Create Passcode")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.headlineLargeSemibold)
                Text("This info needs to be accurate with your ID document")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.bodyMediumRegular).opacity(0.7)
            }
            .padding()
            
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
            Spacer()
            Button {
                Task {
                    await viewModel.postPasscodeData(id: viewModel.userInfoID, passcode: viewModel.passcode, isCompleted: true)
                    
                    if viewModel.success {
                        coordinator.push(.welcome)
                    }
                }
            } label: {
                Text("Continue")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }.disabled(viewModel.caPostCode.isEmpty)
                .padding()
        }
    }
}

#Preview {
    CAPasscode(viewModel: CAViewModel())
}
