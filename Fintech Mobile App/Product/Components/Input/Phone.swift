//
//  Phone.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 7.04.2025.
//

import SwiftUI

struct Phone: View {
    enum FieldState {
        case normal
        case focused
        case error
    }

    var title: String = "Phone"
    @Binding var selectedCountry: Country?
    var placeholder: String = "Phone Number"
    var text: Binding<String>
    var state: FieldState = .normal

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(Typography.labelLargeRegular)
                .foregroundColor(ColorPalette.black)

            HStack(spacing: 8) {
                Picker("Select Country", selection: $selectedCountry) {
                    ForEach(Countries.countries, id: \.code) { country in
                        HStack {
                            Image(country.imageName)
                                .resizable()
                                .frame(width: 24, height: 16)
                                
                            Text(country.code)
                                .font(Typography.labelLargeRegular)
                                
                        }
                        
                        .tag(country)
                    }
                }.tint(ColorPalette.gray900)
                .pickerStyle(MenuPickerStyle())
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                        .frame(height: 55)
                )

                TextField(placeholder, text: text)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .padding()
                    .background(Color.clear)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(borderColor, lineWidth: 2)
                            .frame(height: 55)
                    )
            }
        }
        .onChange(of: isFocused) { newValue in
            // Handle focus change if needed
        }
        .padding()
    }

    private var borderColor: Color {
        switch state {
        case .normal:
            return isFocused ? Color.blue : Color.gray.opacity(0.4)
        case .focused:
            return Color.blue
        case .error:
            return Color.red
        }
    }

    private var helperTextColor: Color {
        state == .error ? .red : .gray
    }
}

#Preview {
    
}
