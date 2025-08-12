//
//  SendView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 3.08.2025.
//

import SwiftUI

struct RecipientView: View {
    @StateObject var viewModel: RecipientViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView(onBack: {coordinator.pop()})
                
                TitleSectionView()
                
                SearchBarView(
                    searchText: $viewModel.searchText,
                    onSearchTap: {
                        Task {
                            await viewModel.getUserDetailsByEmail(email: viewModel.searchText)
                        }
                        
                    }
                )
                
                
                if let selectedReciever = viewModel.selectedReceiver {
                    SendToView(receiver: selectedReciever)
                }
                
                RecipientListView(
                    recievers: viewModel.filteredReceivers,
                    isLoading: viewModel.isLoading,
                    onRecipientTap: { receiver in
                        viewModel.selectReciever(receiver)
                    },
                    showTitle: viewModel.selectedReceiver == nil
                )
                
                Spacer()
                
                ScanToPayButtonView(onScanTap: viewModel.scanToPay)
            }
            .background(Color(UIColor.systemBackground))
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Sub Views
struct HeaderView: View {
    let onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct TitleSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Choose Recipient")
                    .font(Typography.bodyLargeBold)
                    .foregroundColor(ColorPalette.black)
                Spacer()
            }
            
            HStack {
                Text("Please select your recipient to send money")
                    .font(Typography.bodyMediumRegular)
                    .foregroundColor(ColorPalette.black)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    let onSearchTap: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search - Recipients Email", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .onSubmit {
                    onSearchTap()
                }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }
}

struct SendToView: View {
    let receiver: ReceiverUser
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
                
                coordinator.push(.purpose)
                
            } label: {
                HStack(spacing: 16) {
                    ProfileImageView(imageURL: "")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(receiver.fullName)
                            .font(Typography.bodyMediumSemibold)
                            .foregroundColor(ColorPalette.black)
                        
                        Text(receiver.email)
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

struct RecipientListView: View {
    let recievers: [ReceiverUser]
    let isLoading: Bool
    let onRecipientTap: (ReceiverUser) -> Void
    let showTitle: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if showTitle {
                HStack {
                    Text("Most Recent")
                        .font(Typography.bodyLargeSemibold)
                        .foregroundColor(ColorPalette.black)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(recievers.indices, id: \.self) { index in
                            RecipientRowView(
                                recievers: recievers[index],
                                recipient: Recipient(name: "", email: "", amount: ""),
                                onTap: { onRecipientTap(recievers[index]) }
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
        .padding(.top, showTitle ? 32 : 16)
    }
}

struct RecipientRowView: View {
    let recievers: ReceiverUser
    let recipient: Recipient
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            ProfileImageView(imageURL: recipient.profileImageURL)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recievers.fullName)
                    .font(Typography.bodyMediumSemibold)
                    .foregroundColor(ColorPalette.black)
                
                Text(recievers.email)
                    .font(Typography.bodySmallRegular)
                    .foregroundColor(ColorPalette.black)
            }
            
            Spacer()
            
            Text(recipient.amount)
                .font(Typography.bodyMediumSemibold)
                .foregroundColor(ColorPalette.red500)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.clear)
        .onTapGesture(perform: onTap)
    }
}

struct ProfileImageView: View {
    let imageURL: String?
    
    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 50, height: 50)
            .overlay(
                Group {
                    if let imageURL = imageURL {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .font(.title3)
                        }
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                            .font(.title3)
                    }
                }
            )
    }
}

struct ScanToPayButtonView: View {
    let onScanTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: onScanTap) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundColor(.white)
                            .font(.title2)
                    )
            }
            
            Text("Scan To Pay")
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding(.bottom, 40)
    }
}


#Preview {
    RecipientView(viewModel: RecipientViewModel())
}
