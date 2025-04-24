//
//  DateofBirth.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//

import SwiftUI

struct DateofBirth: View {
    @StateObject var viewModel: CAViewModel
    var onConfirm: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            DatePicker("Enter your birthday",
                       selection: $viewModel.caDateofBirth,
                       displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
            Button(action: onConfirm) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorPalette.primary)
                    .font(Typography.bodyMediumSemibold)
                    .foregroundColor(ColorPalette.white)
                    .cornerRadius(30)
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
    DateofBirth(viewModel: CAViewModel(), onConfirm: { })
}
