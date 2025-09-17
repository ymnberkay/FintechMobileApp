//
//  SpendingView.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 28.06.2025.
//

import SwiftUI
import Charts

struct SpendingView: View {
    
    @StateObject var viewModel: SpendingViewModel
    @EnvironmentObject var userManager: UserManager
    
    
    var body: some View {
        ZStack {
            ColorPalette.gray100
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                MonthPickerView(viewModel: viewModel)
                
                HStack(spacing: 15) {
                    
                    BalanceCard(balance: viewModel.totalSpend, image: "creditcard", text: "Total Spend", cardColor: ColorPalette.bgAccent, textColor: ColorPalette.bgLight)
                    
                    BalanceCard(balance: userManager.avaibleBalance, image: "creditcard", text: "Available Balance", cardColor: ColorPalette.bgSecondary, textColor: ColorPalette.black)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ChartView(data: viewModel.data)
                
                
                
                Spacer()
            }
        }
    }
}

#Preview {
    SpendingView(viewModel: SpendingViewModel())
        .environmentObject(UserManager())
}



private struct ChartView: View {
    let data: [WeeklyData]
    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Week", item.weekRange),
                y: .value("Amount", item.amount)
            )
            .foregroundStyle(item.color)
            .cornerRadius(4)
        }
        .padding()
        .frame(height: 200)
        .background(RoundedRectangle(cornerRadius: 20)
            .foregroundColor(ColorPalette.bgLight))
        .padding()
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel {
                    if let intValue = value.as(Double.self) {
                        Text("$\(Int(intValue))")
                            .font(.caption)
                            .foregroundColor(ColorPalette.gray500)
                    }
                }
            }
        }
        
        .chartXAxis {
            AxisMarks(position: .bottom) { value in
                AxisValueLabel {
                    if let stringValue = value.as(String.self) {
                        Text(stringValue)
                            .font(.caption)
                            .foregroundColor(ColorPalette.gray500)
                    }
                }
            }
        }
        .chartYScale(domain: 0...200)
    }
}

struct BalanceCard: View {
    let balance: Double
    let image: String
    let text: String
    let cardColor: Color
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: image)
                    .foregroundColor(textColor)
                Text(text)
                    .foregroundColor(textColor)
                    .font(Typography.bodyMediumRegular)
            }
            
            Text("$\(String(format: "%.2f", balance))")
                .foregroundColor(textColor)
                .font(Typography.bodyLargeSemibold)
        }
        .frame(width: 180, height: 100)
        .background(cardColor)
        .cornerRadius(16)
    }
}

struct MonthPickerView: View {
    @StateObject var viewModel: SpendingViewModel
    var body: some View {
        HStack {
            
            Picker("", selection: $viewModel.selectedMonth) {
                ForEach(SpendingViewModel.monthsSpending, id: \.self) {
                    Text($0)
                    
                }
            }.pickerStyle(.menu)
            
            
            Spacer()
        }.padding()
    }
}
