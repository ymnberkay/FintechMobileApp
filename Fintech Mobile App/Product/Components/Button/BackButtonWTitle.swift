//
//  BackButtonWTitle.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 10.09.2025.
//

import SwiftUI

struct BackButtonWTitle: View {
    let title: String
    let onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            Spacer()
            
            Text(title)
                .font(Typography.bodyLargeSemibold)
                .foregroundColor(ColorPalette.black)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    BackButtonWTitle(title: "My Profile", onBack: {
        
    })
}
