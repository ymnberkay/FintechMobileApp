//
//  OTPTextField.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 15.04.2025.
//
import SwiftUI

struct OTPTextField: View {
    @FocusState private var fieldFocus: Int?
    @Binding var enterValue: [String]
    @State var oldValue = ""
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $enterValue[index], onEditingChanged: { editing in
                    if editing {
                        oldValue = enterValue[index]
                    }
                })
                    .keyboardType(.numberPad)
                    .frame(width: 48, height: 48)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .focused($fieldFocus, equals: index)
                    .tag(index)
                    .onChange(of: enterValue[index]) { newValue in
                        if !newValue.isEmpty {
                            if enterValue[index].count > 1 {
                                let currentValue = Array(enterValue[index])
                                if currentValue[0] == Character(oldValue) {
                                    enterValue[index] = String(enterValue[index].suffix(1))
                                } else {
                                    enterValue[index] = String(enterValue[index].prefix(1))
                                }
                            }
                            if index == 5 {
                                fieldFocus = nil
                            } else {
                                fieldFocus = (fieldFocus ?? 0) + 1
                            }
                        } else {
                            fieldFocus = (fieldFocus ?? 0) - 1
                        }
                    }
            }
        }
    }

}
