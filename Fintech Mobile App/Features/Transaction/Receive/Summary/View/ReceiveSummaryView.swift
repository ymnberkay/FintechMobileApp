//
//  ReceiveSummaryView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 5.09.2025.
//

import SwiftUI

struct ReceiveSummaryView: View {
    @StateObject var viewModel: ReceiveSummaryViewModel
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

                    OneTextButton(title: "Request $\(viewModel.model.amount)") {
                        viewModel.model.userId = userManager.currentUser?.id ?? ""
                        Task {
                            await viewModel.postRequestMoney()
                        }
                        
                    }
                    
                    Spacer()
                }
                .navigationBarHidden(true)
            }.onChange(of: viewModel.requestIsComplete) { oldValue, newValue in
                coordinator.push(.home)
            }
            .onDisappear {
                viewModel.requestIsComplete = false
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
                Text("Send Request")
                    .font(Typography.bodyLargeBold)
                    .foregroundColor(ColorPalette.black)
                
                Text("Please enter an amount to get paid")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(ColorPalette.gray100)
        
    }
}


private struct ReceiverInfoView: View {
    @StateObject var viewModel: ReceiveSummaryViewModel
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
                Text(viewModel.model.toUserName ?? "Berkay Yaman")
                    .font(Typography.bodyMediumBold)
                    .foregroundColor(ColorPalette.black)
                
                Text(viewModel.model.toUserEmail ?? "ymnberkayy@gmail.com" )
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
            }
        }
        .padding(.all)
        .background(RoundedRectangle(cornerRadius: 20.0).fill(ColorPalette.bgLight).frame(width: geo - 20))
    }
}
#Preview {
    ReceiveSummaryView(viewModel: ReceiveSummaryViewModel(model: TransferModel()))
}
