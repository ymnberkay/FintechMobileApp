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
    
    var body: some View {
        ZStack {
            ColorPalette.gray100
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                HStack {
                    
                    Picker("", selection: $viewModel.selectedMonth) {
                        ForEach(SpendingViewModel.monthsSpending, id: \.self) {
                            Text($0)
                            
                        }
                    }.pickerStyle(.menu)
                    
                    
                    Spacer()
                }.padding()
                
                HStack(spacing: 15) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(ColorPalette.bgLight)
                            Text("Total Spend")
                                .foregroundColor(ColorPalette.bgLight)
                                .font(Typography.bodyMediumRegular)
                        }
                        
                        Text("$\(viewModel.balance)")
                            .foregroundColor(ColorPalette.bgLight)
                            .font(Typography.bodyLargeSemibold)
                    }
                    .frame(width: 180, height: 100)
                    .background(Color.blue)
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(ColorPalette.black)
                            Text("Available Balance")
                                .foregroundColor(ColorPalette.black)
                                .font(Typography.bodyMediumRegular)
                        }
                        
                        Text("$\(viewModel.balance)")
                            .foregroundColor(.black)
                            .font(Typography.bodyLargeSemibold)
                    }
                    .frame(width: 180, height: 100)
                    .background(Color.yellow)
                    .cornerRadius(16)
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
