//
//  Password.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 6.04.2025.
//
import SwiftUI

struct Password: View {
    var text: Binding<String>
    @State var isVisible: Bool = false
    var placeholder: String = "Password"
    var label: String = "Password"
    var iconName: String = "envelope"
    @State var state: TextFieldState = .normal
    
    @FocusState private var isFocused: Bool
    
    var borderColor: Color {
        switch state {
        case .normal: return ColorPalette.gray900.opacity(0.4)
        case .focused, .filled: return ColorPalette.primary
        case .error: return ColorPalette.red900
        case .disabled: return ColorPalette.gray900.opacity(0.2)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(Typography.labelLargeRegular)
                .foregroundColor(ColorPalette.black)
            
            HStack {
                Image(iconName)
                    .foregroundColor(state == .disabled ? .gray : .primary)
                SecureField(placeholder, text: text)
                    .font(Typography.labelLargeRegular)
                    .autocorrectionDisabled()
                    .disabled(state == .disabled)
                    .focused($isFocused)
                    .onChange(of: isFocused) { newValue in
                        self.state = .focused
                    }
                    .foregroundColor(state == .disabled ? .gray : .primary)
                
            }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                .frame(height: 55)
        )
    }.padding()
}
}

#Preview {
}
