//
//  EntryView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 14.04.2025.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack(spacing: 24) {
            Image("registration")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
            VStack(spacing: 0) {
                Text("Create your")
                    .font(Typography.titleLargeSemibold)
                Text("Coinpay account")
                    .font(Typography.titleLargeSemibold)
            }
            Text("Coinpay is a powerful too that allows you to easily send, receive, and track your all your transaction.")
                .multilineTextAlignment(.center)
                .font(Typography.bodyMediumRegular)
                .opacity(0.6)
                .padding(.horizontal)
            
            Button {
                coordinator.push(.signUp)
            } label: {
                Text("Sign Up")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.bgLight)
                    .background(RoundedRectangle(cornerRadius: 40).frame(width: 350, height: 60).foregroundColor(ColorPalette.primary))
                    
            }.padding()
            Button {
                coordinator.push(.login)
            } label: {
                Text("Log in")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.primary)
                    .background(RoundedRectangle(cornerRadius: 40)
                        .stroke(ColorPalette.primary, lineWidth: 2).frame(width: 350, height: 60))
                    
            }.padding()
            
            VStack(spacing: 0) {
                Text("By continuing you accept our")
                    .multilineTextAlignment(.center)
                    .font(Typography.bodyMediumRegular)
                    .opacity(0.6)
                Text("Term of use and Privacy Policy")
                    .multilineTextAlignment(.center)
                    .font(Typography.bodyMediumRegular)
                    .opacity(0.6)
            }.padding()

        }
    }
}

#Preview {
    EntryView()
}
