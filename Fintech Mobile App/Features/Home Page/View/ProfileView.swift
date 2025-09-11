//
//  ProfileView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.06.2025.




import SwiftUI

struct ProfileView: View {
    @StateObject private var dataManager = SwiftDataManager.shared
    @StateObject var viewModel = SettingViewModel()
    @EnvironmentObject var coordinator: NavigationCoordinator
    @EnvironmentObject var userManager: UserManager
    
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ColorPalette.gray100
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Text("My Profile")
                            .font(Typography.bodyLargeSemibold)
                            .foregroundColor(ColorPalette.black)
                        Spacer()
                    }
                    
                    PersonalInfoView(name: userManager.currentUser?.fullName ?? "Berkay Yaman", email: userManager.currentUser?.email ?? "ymnberkayy@gmail.com", id: "123123123", width: geo.size.width - 30, circleSize: geo.size.width * 0.2)
                    
                    OneTextButton(title: "Remove Auto Login") {
                        do {
                            try dataManager.deleteAllUsers()
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                    
                    FeatureView(viewModel: viewModel)
                    
                    
                    Spacer()
                    
                    
                    
                }
                
                
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProfileView().environmentObject(UserManager())
}

private struct PersonalInfoView: View {
    let name: String
    let email: String
    let id: String
    let width: Double
    let circleSize: Double
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: circleSize, height: circleSize)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(ColorPalette.black, lineWidth: 2) // kenarlık
                )
            Text(name)
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.black)
            Text(email)
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.black)
            Text(id)
                .font(Typography.bodyMediumRegular)
                .foregroundColor(ColorPalette.black)
            
            
            
        }
        .padding(.all)
        .background(RoundedRectangle(cornerRadius: 20).fill(ColorPalette.bgLight).frame(width: width))
    }
}

struct SettingsRow: View {
    let item: SettingsItem
    
    var body: some View {
        HStack {
            Circle()
                .fill(item.iconBackground)
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: item.icon)
                        .foregroundColor(item.iconColor)
                        .font(.system(size: 20))
                )
            
            Text(item.title)
                .font(Typography.bodyLargeRegular)
                .foregroundColor(ColorPalette.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .contentShape(Rectangle())
        .onTapGesture {
        }
    }
}

struct FeatureView: View {
    @StateObject var viewModel: SettingViewModel
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.settingsItems, id: \.id) { item in
                SettingsRow(item: item)
                
                if item.id != viewModel.settingsItems.last?.id {
                    Divider()
                        .padding(.leading, 90)
                }
            }
        }
        
        .background(RoundedRectangle(cornerRadius: 20.0).fill(ColorPalette.bgLight))
        .padding(.horizontal)
    }
}
