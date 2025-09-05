 //
//  ChooseRecipientView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 27.08.2025.
//

import SwiftUI

struct ChooseRecipientView: View {
    @StateObject var viewModel: ChooseRecipientViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                BackButton(onBack: {coordinator.pop()})
                
                TitleSectionView()
                
                
                
                SearchBarView(
                    searchText: $viewModel.searchText,
                    onSearchTap: {
                        Task {
                            await viewModel.getUserInfoByEmail(email: viewModel.searchText)
                        }
                        
                    }
                )
                
                if let selectedReciever = viewModel.selectedReciever {
                    RecieveSendToView(viewModel: viewModel, receiver: selectedReciever)
                }
                
                HStack {
                    Text("Requests")
                        .font(Typography.bodyLargeBold)
                        .foregroundColor(ColorPalette.black)
                    Spacer()
                }.padding(20)
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.requests, id: \.id) { request in
                            RequestCard(amount: request.amount, name: request.senderUserName, email: request.senderUserEmail, cardHeight: geo.size.height * 0.25, cardWidth: geo.size.width - 30) {
                                
                            } rejectAction: {
                                
                            }

                            
                        }
                        .padding()
                    }
                    
                }
                .scrollIndicators(.hidden)
                .padding()
                
            }.edgesIgnoringSafeArea(.bottom)
            .onAppear {
                Task {
                    await viewModel.getUserTransactionRequest(userId: userManager.currentUser?.id ?? "")
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarHidden(true)
            
        }
    }
}

struct RecieveSendToView: View {
    @StateObject var viewModel: ChooseRecipientViewModel
    let receiver: User
    @EnvironmentObject var coordinator: NavigationCoordinator
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Send to")
                    .font(Typography.bodyLargeSemibold)
                    .foregroundColor(ColorPalette.black)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Button {
                viewModel.model.toUserId = receiver.id
                viewModel.model.toUserName = receiver.fullName
                viewModel.model.toUserEmail = receiver.email
                coordinator.push(.ReceiveChoosePurpose)
                
            } label: {
                HStack(spacing: 16) {
                    ProfileImageView(imageURL: "")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(receiver.fullName ?? "")
                            .font(Typography.bodyMediumSemibold)
                            .foregroundColor(ColorPalette.black)
                        
                        Text(receiver.email ?? "")
                            .font(Typography.bodyMediumRegular)
                            .foregroundColor(ColorPalette.black)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
                .padding(.horizontal, 20)
            }
            
            
        }
        .padding(.top, 16)
    }
}

#Preview {
    ChooseRecipientView(viewModel: ChooseRecipientViewModel(model: TransferModel()))
}
