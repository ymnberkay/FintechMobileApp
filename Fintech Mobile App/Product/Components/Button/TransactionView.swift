//
//  TransactionView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 10.06.2025.
//

import SwiftUI

struct TransactionView: View {
    var imageName: String
    var text: String
    var price: Double
    var buttonBackColor: Color
    var onClick: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            Button(action: onClick) {
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.07, height: geo.size.width * 0.06)
                        .foregroundColor(buttonBackColor)
                        .padding()
                        .background(Circle()
                            .fill(buttonBackColor).opacity(0.2)
                            .frame(width: geo.size.width * 0.2))
                    
                    Text(text)
                        .font(Typography.labelLargeMedium)
                        .foregroundColor(ColorPalette.contentPrimary)
                    
                    Spacer()
                    
                    Text(String(format: "%.2f", price))
                        .font(Typography.labelLargeMedium)
                        .foregroundColor(ColorPalette.contentPrimary)
                        .padding(.horizontal)
                    Image(systemName: "chevron.right")
                        .foregroundColor(ColorPalette.contentPrimary)
                }.padding(.horizontal)
                
            }
        }
        
    }
}

#Preview {
    TransactionView(imageName: "creditcard.fill", text: "Spending", price: 123.1, buttonBackColor: ColorPalette.blue500, onClick: { })
}
