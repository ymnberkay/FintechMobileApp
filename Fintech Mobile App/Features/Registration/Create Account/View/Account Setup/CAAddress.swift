//
//  CAAdress.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//
import SwiftUI

struct CAAddress: View {
    @StateObject var viewModel: CAViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Add your personal information")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.headlineLargeSemibold)
                Text("This info needs to be accurate with your ID\n document")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.bodyMediumRegular).opacity(0.7)
            }
            .padding(.vertical)
            
            TextInput(text: $viewModel.caAddress, placeholder: "Mr. Jhon Doe", label: "Address Line")
            
            TextInput(text: $viewModel.caCity, placeholder: "City, State", label: "City")
            
            TextInput(text: $viewModel.caPostCode, placeholder: "Ex:00000", label: "Postcode")
                .keyboardType(.numberPad)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.postAddressData(id: viewModel.userInfoID, addressLine: viewModel.caAddress, city: viewModel.caCity, postCode: viewModel.caPostCode)
                    
                    if viewModel.success {
                        coordinator.push(.caEmail)
                    }
                    
                }
                
            } label: {
                Text("Continue")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }.disabled(viewModel.caAddress.isEmpty && viewModel.caCity.isEmpty && viewModel.caPostCode.isEmpty)
            .padding()
        }
    }
}
#Preview {
    CAAddress(viewModel: CAViewModel())
}
