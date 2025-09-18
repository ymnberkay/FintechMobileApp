//
//  RecentTransactionView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 12.09.2025.
//

import SwiftUI

struct RecentTransactionView: View {
    @StateObject var viewModel: RecentTransactionViewModel = RecentTransactionViewModel()
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    BackButtonWTitle(title: "Recent Transactions") {
                        coordinator.pop()
                    }

                    TransactionListView(
                        recievers: viewModel.recentTransactions,
                        isLoading: viewModel.isSuccess)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getUserTransaction(userID: userManager.currentUser?.id ?? "")
                }
                
            }
            .navigationBarHidden(true)
            
        }
    }
}

#Preview {
    RecentTransactionView(viewModel: RecentTransactionViewModel())
        .environmentObject(UserManager())
}


private struct TransactionRowView: View {
    let recievers: Transaction
    let recipient: Recipient
    
    var body: some View {
        HStack(spacing: 16) {
            ProfileImageView(imageURL: recipient.profileImageURL)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recievers.toUserName)
                    .font(Typography.bodyMediumSemibold)
                    .foregroundColor(ColorPalette.black)
                
                Text(recievers.toUserEmail)
                    .font(Typography.bodySmallRegular)
                    .foregroundColor(ColorPalette.black)
            }
            
            Spacer()
            
            Text("\(recievers.amount)")
                .font(Typography.bodyMediumSemibold)
                .foregroundColor(ColorPalette.red500)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.clear)
    }
}

private struct TransactionListView: View {
    let recievers: [Transaction]
    let isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if !isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(recievers.indices, id: \.self) { index in
                            TransactionRowView(
                                recievers: recievers[index],
                                recipient: Recipient(name: "", email: "", amount: "")
                            )
                            
                            if index < recievers.count - 1 {
                                Divider()
                                    .padding(.leading, 80)
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}
