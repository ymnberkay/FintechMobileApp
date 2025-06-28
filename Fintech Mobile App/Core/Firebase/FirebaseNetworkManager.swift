//
//  FirebaseNetworkManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 24.04.2025.
//

import Combine
import FirebaseCore
import FirebaseAuth

protocol IFirebaseNetworkManager {
    func sendVerificationCode(phoneNumber: String) -> AnyPublisher<String, Error>
    func verifyCode(verificationCode: String) -> AnyPublisher<AuthDataResult, Error>
    
}

extension FirebaseNetworkManager {
    static let firebaseNetworkManager: IFirebaseNetworkManager = FirebaseNetworkManager()
}

class FirebaseNetworkManager: IFirebaseNetworkManager {
    init() {
        
    }
    func sendVerificationCode(phoneNumber: String) -> AnyPublisher<String, Error> {
        return Future { promise in
            let phoneProvider = PhoneAuthProvider.provider()
            phoneProvider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    promise(.failure(error))
                } else if let verificationID = verificationID {
                    // Verification ID'yi geri dönüyoruz
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    promise(.success(verificationID))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func verifyCode(verificationCode: String) -> AnyPublisher<AuthDataResult, Error> {
        return Future { promise in
            guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
                promise(.failure(NSError(domain: "NetworkManager", code: 100, userInfo: [NSLocalizedDescriptionKey: "Verification ID not found"])))
                return
            }
            
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let authResult = authResult {
                    promise(.success(authResult))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
