//
//  AlertCorrect.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//

import SwiftUI

struct AlertCorrect: View {
    var phoneNumber: String
    var countryCode: String
    var onConfirm: () -> Void
    var onCancel: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Image("phoneCorrect")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            VStack {
                Text("Verify your phone number")
                    .font(Typography.headlineLargeSemibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("before we send code")
                    .font(Typography.headlineLargeSemibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Text("Is this correct? \(countryCode+phoneNumber)")
                .font(Typography.subheadSmallRegular)
                .opacity(0.6)
            
            Button(action: onConfirm) {
                Text("Yes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorPalette.primary)
                    .font(Typography.bodyMediumSemibold)
                    .foregroundColor(ColorPalette.white)
                    .cornerRadius(30)
            }
            
            Button(action: onCancel) {
                Text("No")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(ColorPalette.primary)
                    .font(Typography.bodyMediumSemibold)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(ColorPalette.primary, lineWidth: 2)
                    )
            }
        }
        .padding()
        .frame(width: 350, height: 500)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .padding(.horizontal, 30)
    }
}

#Preview {
    AlertCorrect(phoneNumber: "5367324432", countryCode: "+90", onConfirm: {}, onCancel: {})
}
