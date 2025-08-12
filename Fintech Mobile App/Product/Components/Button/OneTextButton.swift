//
//  OneTextButton.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.08.2025.
//

import SwiftUI

struct OneTextButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Typography.bodyLargeSemibold)
                .foregroundColor(ColorPalette.contentOnColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(ColorPalette.primary)
                .cornerRadius(30)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    OneTextButton(title: "Pay $500") {
        
    }
}
