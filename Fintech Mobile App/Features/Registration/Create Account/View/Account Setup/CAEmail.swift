//
//  CAEmail.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 18.04.2025.
//

import SwiftUI

struct CAEmail: View {
    @StateObject var viewModel: CAViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Add your email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.headlineLargeSemibold)
                Text("This info needs to be accurate with your ID\n document")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.bodyMediumRegular).opacity(0.7)
            }
            .padding(.vertical)
            
            Email(text: $viewModel.caEmail, placeholder: "name@example.com", label: "Email")
            Spacer()
            Button {
                Task {
                    await viewModel.postEmailData(id: viewModel.userInfoID, email: viewModel.caEmail)
                    
                    if viewModel.success {
                        coordinator.push(.caPasscode)
                    }
                }
            } label: {
                Text("Continue")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }.disabled(viewModel.caEmail.isEmpty)
            .padding()
        }.onAppear {
            viewModel.success = false
        }
    }
}

#Preview {
    CAEmail(viewModel: CAViewModel())
}
