//
//  RootViewModel.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//
import Foundation
import SwiftData

final class RootViewModel: ObservableObject {
    @Published var currentUser: PasscodeUser? = nil
    var context: ModelContext? = nil
    
    func loadCurrentUser() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<PasscodeUser>()
            let users = try context.fetch(descriptor)
            currentUser = users.first
        } catch {
            print("Failed to fetch user:", error)
        }
    }
    
    func saveUser(_ user: PasscodeUser) {
        context?.insert(user)
        do {
            try context?.save()
            currentUser = user
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    func deleteUser() {
        if let user = currentUser {
            context?.delete(user)
            do {
                try context?.save()
                currentUser = nil
            } catch {
                print("Failed to delete user: \(error)")
            }
        }
    }
    
}
