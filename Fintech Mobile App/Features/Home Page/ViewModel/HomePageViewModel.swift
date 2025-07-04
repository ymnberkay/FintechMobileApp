//
//  HomePageViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 1.06.2025.
//

import Foundation


final class HomePageViewModel: ObservableObject {
    @Published var searchableObject: String = ""
    @Published var balance: Double = 0.0
}
