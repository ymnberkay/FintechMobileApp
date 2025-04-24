//
//  TextInputButton.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//

import SwiftUI

struct TextInputButton: View {
    var text: String
    var placeholder: String
    var label: String
    var onClick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(Typography.labelLargeRegular)
                .foregroundColor(ColorPalette.black)

            HStack {
                Button(action: onClick) {
                    Text(text.isEmpty ? placeholder : text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Typography.labelLargeRegular)
                        .foregroundColor(ColorPalette.gray900.opacity(0.4))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(ColorPalette.gray900.opacity(0.4), lineWidth: 1.5)
            )
        }.padding()

    }
}
#Preview {
    TextInputButton(text: "", placeholder: "Deneme", label: "", onClick: { })
}
