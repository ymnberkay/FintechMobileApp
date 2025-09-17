//
//  DashbordView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.06.2025.
//

import SwiftUI

struct DashbordView: View {
    @StateObject private var dataManager = SwiftDataManager.shared
    @EnvironmentObject var userManager: UserManager
    @State private var selectedTab = 0
    @StateObject var homePageViewModel: HomePageViewModel
    @StateObject var spendingViewModel: SpendingViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomePageView(viewModel: homePageViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(userManager)
                .tag(0)
            
            SpendingView(viewModel: spendingViewModel)
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Spend")
                }
                .environmentObject(userManager)
                .tag(1)
            
            CustomerSupportView()
                .tabItem {
                    Image(systemName: "text.bubble")
                    Text("Customer Support")
                    
                }
                .environmentObject(userManager)
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .environmentObject(userManager)
                .tag(3)
        }
        .onAppear {
            print("📱 Dashboard onAppear - UserID: '\(userManager.currentUser?.id))'")
            if userManager.currentUser?.id != nil {
                Task {
                    await homePageViewModel.getBalanceData(userId: userManager.currentUser?.id ?? "")
                    await userManager.fetchUserInfo(userManager.currentUser?.id ?? "")
                    userManager.setAvaibleBalance(homePageViewModel.balance)
                    print("💰 Balance loaded: \(homePageViewModel.balance)")
                    if !dataManager.isProfileComplete {
                        do {
                            try dataManager.completeUserProfile(
                                name: userManager.currentUser?.fullName ?? "",
                                email: userManager.currentUser?.email ?? ""
                            )
                            
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                    
                }
            } else {
                print("❌ UserID is empty in Dashboard!")
            }
           
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashbordView(homePageViewModel: HomePageViewModel(), spendingViewModel: SpendingViewModel())
        .environmentObject(UserManager())
}
