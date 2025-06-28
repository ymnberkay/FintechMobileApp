//
//  TextButtonArrow.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 4.06.2025.
//

import SwiftUI

struct TextButtonArrow: View {
    var onClick: () -> Void
    var body: some View {
        HStack {
            Text("Transaction")
                .font(Typography.titleSmallMedium)
            Spacer()
            Button(action: onClick) {
                Image(systemName: "arrow.right")
                    .foregroundColor(ColorPalette.black)
            }
            
        }
        .padding()
    }
}

#Preview {
    TextButtonArrow(onClick: { })
}
