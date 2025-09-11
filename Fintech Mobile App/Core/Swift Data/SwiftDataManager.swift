//
//  SwiftDataManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

//
//  SwiftDataManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 11.09.2025.
//

import Foundation
import SwiftData

enum DataManagerError: Error {
    case contextNotAvailable
    case fetchFailed(Error)
    case saveFailed(Error)
    case deleteFailed(Error)
    case userNotFound
    
    var localizedDescription: String {
        switch self {
        case .contextNotAvailable:
            return "Database context is not available"
        case .fetchFailed(let error):
            return "Failed to fetch data: \(error.localizedDescription)"
        case .saveFailed(let error):
            return "Failed to save data: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Failed to delete data: \(error.localizedDescription)"
        case .userNotFound:
            return "User not found"
        }
    }
}

@MainActor
final class SwiftDataManager: ObservableObject {
    static let shared = SwiftDataManager()
    
    @Published var currentUser: PasscodeUser?
    
    private var context: ModelContext?
    
    private init() {}
    
    // MARK: - Setup
    func setupContext(with container: ModelContainer) {
        context = ModelContext(container)
        loadCurrentUser()
    }
    
    // MARK: - User Management
    func loadCurrentUser() {
        guard let context else {
            print("Context not available")
            return
        }
        
        do {
            let descriptor = FetchDescriptor<PasscodeUser>()
            let users = try context.fetch(descriptor)
            currentUser = users.first
            
            // Debug
            print("Loaded user: \(currentUser?.id ?? "No user found")")
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
    }
    
    // Login ekranında - ID ve phone number ile kullanıcı oluştur
    func createInitialUser(id: String, phoneNumber: String) throws {
        guard let context else {
            throw DataManagerError.contextNotAvailable
        }
        
        let user = PasscodeUser(
            id: id,
            name: "",
            email: "",
            phoneNumber: phoneNumber
        )
        
        context.insert(user)
        
        do {
            try context.save()
            currentUser = user
            print("Initial user created with ID: \(id) and phone: \(phoneNumber)")
        } catch {
            throw DataManagerError.saveFailed(error)
        }
    }
    
    // Home view'da - name ve email'i tamamla
    func completeUserProfile(name: String, email: String) throws {
        guard let context else {
            throw DataManagerError.contextNotAvailable
        }
        
        guard let user = currentUser else {
            throw DataManagerError.userNotFound
        }
        
        user.name = name
        user.email = email
        
        do {
            try context.save()
            print("User profile completed: \(name) - \(email)")
        } catch {
            throw DataManagerError.saveFailed(error)
        }
    }
    
    func deleteCurrentUser() throws {
        guard let context else {
            throw DataManagerError.contextNotAvailable
        }
        
        guard let user = currentUser else {
            throw DataManagerError.userNotFound
        }
        
        context.delete(user)
        
        do {
            try context.save()
            currentUser = nil
            print("User deleted successfully")
        } catch {
            throw DataManagerError.deleteFailed(error)
        }
    }
    
    
    func deleteAllUsers() throws {
        guard let context else {
            throw DataManagerError.contextNotAvailable
        }
        
        do {
            let descriptor = FetchDescriptor<PasscodeUser>()
            let allUsers = try context.fetch(descriptor)
            
            for user in allUsers {
                context.delete(user)
            }
            
            try context.save()
            currentUser = nil
            
            print("All users deleted successfully. Count: \(allUsers.count)")
        } catch {
            throw DataManagerError.deleteFailed(error)
        }
    }
    
    
    // MARK: - User State Checks
    var hasUser: Bool {
        return currentUser != nil
    }
    
    var isProfileComplete: Bool {
        guard let user = currentUser else { return false }
        return !user.name.isEmpty && !user.email.isEmpty
    }
    
    var userPhoneNumber: String? {
        return currentUser?.phoneNumber
    }
    
    // MARK: - Debug
    func printUserInfo() {
        if let user = currentUser {
            print("Current User:")
            print("- ID: \(user.id)")
            print("- Name: \(user.name.isEmpty ? "Not set" : user.name)")
            print("- Email: \(user.email.isEmpty ? "Not set" : user.email)")
            print("- Phone: \(user.phoneNumber)")
            print("- Profile Complete: \(isProfileComplete)")
        } else {
            print("No user found in database")
        }
    }
}
