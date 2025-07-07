//
//  CAName.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//

import SwiftUI

struct CAName: View {
    @StateObject var viewModel: CAViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack {
                    Text("Add your personal information")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.headlineLargeSemibold)
                    Text("This info needs to be accurate with your ID document")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .font(Typography.bodyMediumRegular).opacity(0.7)
                }
                .padding(.vertical)
                
                TextInput(text: $viewModel.caName, placeholder: "Mr. Jhon Doe", label: "Full Name")
                
                TextInput(text: $viewModel.caUsername, placeholder: "@username", label: "Username").autocapitalization(.none)
                
                TextInputButton(text: String("\(viewModel.caDateofBirth)".prefix(11)) , placeholder: "MM/DD/YYYY", label: "Date of Birth") {
                    viewModel.showBirthDateAllert = true
                }
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.postNameData(id: viewModel.userInfoID, fullName: viewModel.caName, userName: viewModel.caUsername, dateofBirth: String("\(viewModel.caDateofBirth)".prefix(11)))
                        
                        if viewModel.success {
                            coordinator.push(.caAdress)
                        }
                    }
                    
                } label: {
                    Text("Continue")
                        .font(Typography.bodyLargeSemibold)
                        .foregroundColor(ColorPalette.bgLight)
                        .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                        
                }.disabled(viewModel.caName.isEmpty && viewModel.caUsername.isEmpty).padding()
            }
            if viewModel.showBirthDateAllert {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                DateofBirth(viewModel: viewModel) {
                    viewModel.showBirthDateAllert = false
                }
            }
        }.onAppear {
            viewModel.success = false
        }

    }
}

#Preview {
    CAName(viewModel: CAViewModel())
}
