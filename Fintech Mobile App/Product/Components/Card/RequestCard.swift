//
//  RequestCard.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 29.08.2025.
//

import SwiftUI


struct RequestCard: View {
    var amount: Double
    var name: String
    var email: String
    var cardHeight: CGFloat = 180.0
    var cardWidth: CGFloat = 380.0
    let acceptAction: () -> Void
    let rejectAction: () -> Void
   
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 2)
                    )
                    .foregroundColor(.gray)
                    .padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(Typography.bodyMediumBold)
                        .foregroundColor(ColorPalette.black)
                    
                    Text(email)
                        .font(Typography.bodyMediumBold)
                        .foregroundColor(ColorPalette.black)
                    
                    Text("$\(String(format: "%.2f", amount))")
                        .font(Typography.bodyMediumBold)
                        .foregroundColor(ColorPalette.black)
                }
            }
            
            HStack(spacing: 16) {
                Button(action: acceptAction) {
                    Text("Accept")
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.bgLight)
                        .frame(width: 80, height: 36)
                        .background(ColorPalette.bgSuccess)
                        .cornerRadius(18)
                }
                
                Button(action: rejectAction) {
                    Text("Reject")
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.bgLight)
                        .frame(width: 80, height: 36)
                        .background(ColorPalette.bgError)
                        .cornerRadius(18)
                }
            }
            
            
        }
        
        .padding(32)
        .frame(width: cardWidth, height: cardHeight)
        .background(RoundedRectangle(cornerRadius: 20).fill(ColorPalette.gray100))
    }
}
#Preview {
    RequestCard(amount: 100.0, name: "Berkay", email: "ymnberkayy@gmail.com") {
        
    } rejectAction: {
        
    }
    
}
