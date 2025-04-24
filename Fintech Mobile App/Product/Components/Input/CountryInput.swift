//
//  CountryInput.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 9.04.2025.
//
import SwiftUI

struct CountryInput: View {
    @Binding var selectedCountry: Country?
    
    var body: some View {
        GeometryReader { geometry in
            Picker("Select Country", selection: $selectedCountry) {
                ForEach(Countries.countries, id: \.code) { country in
                    HStack {
                        Image(country.imageName)
                            .resizable()
                            .frame(width: 24, height: 16)
                        
                        Text(country.name)
                            .font(Typography.labelLargeRegular)
                    }
                    .tag(country)
                }
            }
            
            .tint(ColorPalette.gray900)
            .frame(width: geometry.size.width)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                    .frame(height: 55)
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    
}
