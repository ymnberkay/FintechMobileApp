//
//  ReceivePurposeView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 4.09.2025.
//

import SwiftUI

struct RecievePurposeView: View {
    @StateObject var viewModel: ReceivePurposeViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        ZStack {
            ColorPalette.gray100
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                // Header
                headerView
                
                // Content
                contentView
                
                OneTextButton(title: "Continue") {
                    viewModel.updateTransferModel()
                    coordinator.push(.ReceiveAmount)
                    
                }
                
                Spacer()

            }
            .navigationBarHidden(true)
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            BackButton {
                coordinator.pop()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Select a Purpose")
                    .font(Typography.bodyLargeBold)
                    .foregroundColor(ColorPalette.black)
                
                Text("Select a method for sending money")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(ColorPalette.gray100)
    }
    
    private var contentView: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.purposes, id: \.id) { purpose in
                RecievePurposeSelectionRow(
                    purpose: purpose,
                    isSelected: viewModel.selectedPurpose?.id == purpose.id
                ) {
                    viewModel.selectPurpose(purpose)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    
}

struct RecievePurposeSelectionRow: View {
    let purpose: TransferPurpose
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(purpose.iconBackgroundColor.opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: purpose.iconName)
                        .font(.system(size: 20))
                        .foregroundColor(purpose.iconBackgroundColor)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 4) {
                    Text(purpose.title)
                        .font(Typography.headlineSmallSemibold)
                        .foregroundColor(ColorPalette.contentPrimary)
                    
                    Text(purpose.subtitle)
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.contentSecondary)
                }
                
                Spacer()
                
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(isSelected ? ColorPalette.primary : ColorPalette.gray300, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(ColorPalette.primary)
                            .frame(width: 14, height: 14)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(ColorPalette.bgLight)
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    RecievePurposeView(viewModel: ReceivePurposeViewModel(model: TransferModel()))
}
