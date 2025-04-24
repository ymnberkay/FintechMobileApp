//
//  CACountry.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//
import SwiftUI

struct CACountry: View {
    @StateObject var viewModel: CAViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Country Of Residence")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.headlineLargeSemibold)
                Text("This info needs to be accurate with your ID document")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .font(Typography.bodyMediumRegular).opacity(0.7)
            }
            .padding(.vertical)
            
            CountryInput(selectedCountry: $viewModel.countryValue)
            
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.postResidenceData(requestString: viewModel.countryValue?.name ?? "")
                    if viewModel.success {
                        coordinator.push(.caName)
                    }
                    
                }
                
            } label: {
                Text("Continue")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }
            .padding()
        }
    }
}

#Preview {
    CACountry(viewModel: CAViewModel())
}
