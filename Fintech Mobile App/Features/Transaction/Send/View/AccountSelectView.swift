//
//  AccountSelectView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 25.08.2025.
//

import SwiftUI

struct AccountSelectView: View {
    @StateObject var viewModel: TransactionViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ColorPalette.gray100
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    headerView
                    
                    ReceiverInfoView(viewModel: viewModel, geo: geo.size.width)
                    
                    SenderInfoView(viewModel: viewModel, geo: geo.size.width)
                    
                    
                    OneTextButton(title: "Pay $\(viewModel.amount)") {
                        Task {
                            await viewModel.postCreateTransaction(id: userManager.currentUser?.id ?? "")
                        }
                        
                    }
                    
                    Spacer()
                }
                .navigationBarHidden(true)
            }.onChange(of: viewModel.transactionIsComplete) { oldValue, newValue in
                coordinator.push(.transactionSummary)
            }
        }
        
    }
    // MARK: - Header View
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 16) {
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
}

#Preview {
    AccountSelectView(viewModel: TransactionViewModel())
        .environmentObject(UserManager())
}

private struct ReceiverInfoView: View {
    @StateObject var viewModel: TransactionViewModel
    var geo: CGFloat
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 2)
                )
                .foregroundColor(.gray)
            
            VStack(spacing: 4) {
                Text(viewModel.selectedReciever?.fullName ?? "Berkay Yaman")
                    .font(Typography.bodyMediumBold)
                    .foregroundColor(ColorPalette.black)
                
                Text(viewModel.selectedReciever?.email ?? "ymnberkayy@gmail.com" )
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
        }
        .padding(.all)
        .background(RoundedRectangle(cornerRadius: 20.0).fill(ColorPalette.bgLight).frame(width: geo - 20))
    }
}

private struct SenderInfoView: View {
    @StateObject var viewModel: TransactionViewModel
    @EnvironmentObject var userManager: UserManager
    var geo: CGFloat
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Sender Account Information")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.black)
                    .padding(.bottom, 20)
                Spacer()
            }
            VStack(spacing: 16) {
                Text("Id: \(String(describing: userManager.currentUser?.id ?? "Sender ID"))")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
                Text("Name: \(String(describing: userManager.currentUser?.fullName ?? "Sender Name"))")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
                Text("Email: \(String(describing: userManager.currentUser?.email ?? "senderEmail@gmail.com"))")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
            .padding(.all)
            .background(RoundedRectangle(cornerRadius: 20.0).fill(ColorPalette.bgLight).frame(width: geo - 20))
            
            
            
            
        }.padding()
    }
}
