//
//  TransactionSummaryView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 27.08.2025.
//

import SwiftUI

struct TransactionSummaryView: View {
    @StateObject var viewModel: TransactionViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ColorPalette.gray100
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        Image("check-circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .padding(.leading)
                        
                        Text("Transaction Complete! - \(viewModel.createdTransaction.createdAt)")
                            .font(Typography.bodySmallRegular)
                            .foregroundColor(ColorPalette.gray800)
                            
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 5.0).fill(ColorPalette.green200).frame(width: geo.size.width - 20, height: geo.size.height * 0.05))
                    .padding(.vertical)
                    
                    ReceiverInfoView(viewModel: viewModel, geo: geo.size.width)
                    
                    SenderInfoView(viewModel: viewModel, geo: geo.size.width)
                    
                    Spacer()
                    
                    OneTextButton(title: "Back to Homepage") {
                        coordinator.push(.home)
                        
                    }
                    
                    OneTextButton(title: "Make another Payment") {
                        
                        
                    }
                    Text("Thank you for using our app to send money. If you have any quesiton or concerns contact us")
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                }
                .navigationBarHidden(true)
            }
        }
        
    }
    
}


#Preview {
    TransactionSummaryView(viewModel: TransactionViewModel())
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
                
                Text("Coinpay Transaction ID: \(viewModel.createdTransaction.id)" )
                    .font(Typography.bodyMediumBold)
                    .foregroundColor(ColorPalette.blue500)
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
                Text("Account")
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
