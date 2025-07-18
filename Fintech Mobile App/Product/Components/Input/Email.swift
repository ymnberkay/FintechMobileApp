//
//  Email.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//
import SwiftUI

struct Email: View {
    var text: Binding<String>
    var placeholder: String
    var label: String
    var iconName: String = "envelope"

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(Typography.labelLargeRegular)
                .foregroundColor(ColorPalette.black)

            HStack {
                Image(iconName)

                TextField(placeholder, text: text)
                    .autocorrectionDisabled()
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
}
