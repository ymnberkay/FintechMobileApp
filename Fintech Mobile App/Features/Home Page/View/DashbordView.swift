//
//  DashbordView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.06.2025.
//

import SwiftUI

struct DashbordView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var selectedTab = 0
    @StateObject var homePageViewModel: HomePageViewModel
    @StateObject var spendingViewModel: SpendingViewModel
    
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
            userManager.setUserID(userManager.currentUserID)
        }
    }
}

#Preview {
    DashbordView(homePageViewModel: HomePageViewModel(), spendingViewModel: SpendingViewModel())
        .environmentObject(UserManager())
}
