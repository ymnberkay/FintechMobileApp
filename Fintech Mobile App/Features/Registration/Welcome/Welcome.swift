//
//  Welcome.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 24.04.2025.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(spacing: 16) {
            Image("registrationCompleted")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()
            
            VStack {
                Text("Congratulations!")
                    .multilineTextAlignment(.center)
                    .font(Typography.titleLargeBold)
                Text("Welcome to Coinpay")
                    .multilineTextAlignment(.center)
                    .font(Typography.titleLargeBold)
            }
            .padding()
            
            Text("We are happy to have you. It's time to send, receive and track ")
                .multilineTextAlignment(.center)
                .font(Typography.bodyMediumRegular).opacity(0.7)
                .padding()
            
            Spacer()
            
            Button {
                coordinator.push(.login)
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
    Welcome()
}
