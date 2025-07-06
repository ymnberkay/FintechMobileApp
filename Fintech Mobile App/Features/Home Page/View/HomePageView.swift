//
//  HomePageView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 14.05.2025.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var viewModel: HomePageViewModel
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                ColorPalette.border.opacity(0.5).edgesIgnoringSafeArea(.bottom)
                
                ColorPalette.bgAccent
                    .frame(height: geo.size.height / 2.1)
                    .edgesIgnoringSafeArea(.top)
                    
                VStack(spacing: 16) {
                    VStack(spacing: 16) {
                        TopBarView()
                        BalanceView(viewModel: viewModel)
                    }.padding(.bottom, 4)
                    
                    HStack (spacing: 36){
                        
                        SRBButtonView(imageName: "arrow.up.circle.fill", text: "Send", buttonColor: ColorPalette.primary) {
                            
                        }
                        Divider()
                        
                        SRBButtonView(imageName: "arrow.down.circle.fill", text: "Request", buttonColor: ColorPalette.secondary) {
                            
                        }
                        Divider()
                        
                        SRBButtonView(imageName: "building.columns.fill", text: "Bank", buttonColor: ColorPalette.secondary) {
                            
                        }
                    }.padding().frame(width: geo.size.width*0.9, height: geo.size.height * 0.1).background(RoundedRectangle(cornerRadius: 15).fill(ColorPalette.bgLight))
                    
                    TextButtonArrow(text: "Transaction" ,onClick: {
                        
                    })
                    
                    VStack(spacing: 16) {
                        TransactionView(imageName: "creditcard.fill", text: "Spending", price: 123.1, buttonBackColor: ColorPalette.blue500, onClick: { })
                        Divider()
                            .padding(.horizontal)
                        TransactionView(imageName: "dollarsign.circle", text: "Income", price: 123.1, buttonBackColor: ColorPalette.green500, onClick: { })
                        Divider()
                            .padding(.horizontal)
                        TransactionView(imageName: "doc.text.magnifyingglass", text: "Bills", price: 123.1, buttonBackColor: ColorPalette.yellow500, onClick: { })
                        Divider()
                            .padding(.horizontal)
                        TransactionView(imageName: "creditcard.fill", text: "Savings", price: 123.1, buttonBackColor: ColorPalette.orange500, onClick: { })
                        
                        
                    }.padding()
                        .background(RoundedRectangle(cornerRadius: 15.0).fill(ColorPalette.bgLight).frame(width: geo.size.width * 0.93))
                    Spacer()
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
        
        
        
    }
    
}

#Preview {
    HomePageView(viewModel: HomePageViewModel())
}

private struct TopBarView: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFit()
                    .foregroundColor(ColorPalette.bgLight)
            }
            Spacer()
            Button {
                
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFit()
                        .foregroundColor(ColorPalette.contentOnColor)
                    
                    Text("Search \"Payments\"")
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.contentOnColor)
                    Spacer()
                }.padding().frame(width: 240,height: 36).background(RoundedRectangle(cornerRadius: 20).fill(ColorPalette.blue100))
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFit()
                    .foregroundColor(ColorPalette.bgLight)
            }
            
        }.padding()
    }
}

struct BalanceView: View {
    @StateObject var viewModel: HomePageViewModel
    var body: some View {
        VStack(spacing: 16) {
            Text("$\(viewModel.balance)")
                .font(Typography.titleLargeXBold)
                .foregroundColor(ColorPalette.bgLight)
            Text("Available Balance")
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.bgLight)
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(ColorPalette.bgLight)
                    Text("Add Money")
                        .font(Typography.bodyMediumRegular)
                        .foregroundColor(ColorPalette.bgLight)
                }.padding().background(RoundedRectangle(cornerRadius: 20.0).stroke(lineWidth: 2.0).foregroundColor(ColorPalette.bgLight))
            }
            
        }
    }
}

private struct SRBButtonView: View {
    var imageName: String
    var text: String
    var buttonColor: Color
    var onClick: () -> Void
    var body: some View {
        Button(action: onClick) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                    .foregroundColor(buttonColor)
                Text(text)
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.contentPrimary)
            }
        }
    }
}
