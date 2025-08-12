//
//  BackButton.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.08.2025.
//

import SwiftUI

struct BackButton: View {
    let onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    BackButton {
        
    }
}
