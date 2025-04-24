//
//  NavigationCordinator.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 14.04.2025.
//
import SwiftUI

final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ screen: Screen) {
        path.append(screen)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
