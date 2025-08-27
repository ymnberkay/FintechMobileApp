//
//  NetworkManager.swift
//  Fintech Mobile App
//
//  Created by Berkay Yaman on 17.04.2025.
//
import Alamofire
import Foundation

struct NetworkConfig {
    let baseUrl: String
}

enum NetworkPath {
    case PIResidence
    case PIName
    case PIAdress
    case PIEmail
    case PIPasscode
    case Register
    case Login
    case GetBalance(userId: String)
    case CreateBalance
    case PIFetchFullData(userId: String)
    case PIFetchFullDataByEmail(email: String)
    case GetUserTransactions(userId: String)
    case CreateTransaction
    
    var rawValue: String {
        switch self {
        case .PIResidence:
            return "api/PersonalInfo/residence"
        case .PIName:
            return "api/PersonalInfo/name"
        case .PIAdress:
            return "api/PersonalInfo/adress"
        case .PIEmail:
            return "api/PersonalInfo/email"
        case .PIPasscode:
            return "api/PersonalInfo/passcode"
        case .Register:
            return "api/Auth/register"
        case .Login:
            return "api/Auth/login"
        case .GetBalance(let userId):
            return "api/Balance/\(userId)"
        case .CreateBalance:
            return "api/Balance"
        case .PIFetchFullData(let userId):
            return "api/PersonalInfo/\(userId)"
        case .PIFetchFullDataByEmail(let email):
            return "api/PersonalInfo/by-email?email=\(email)"
        case .GetUserTransactions(let email):
            return "api/Transaction/\(email)"
        case .CreateTransaction:
            return "api/Transaction"
        
        }
    }
    
    static let baseUrl: String = "http://localhost:5245/"
}

protocol INetworkManager {
    func get<T: Codable>(path: NetworkPath, type: T.Type) async -> T?
    func post<T: Codable, R: Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T?
    var config: NetworkConfig { get set }
}

extension NetworkManager {
    static let networkManager: INetworkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))
}

class NetworkManager: INetworkManager {
    var config: NetworkConfig
    let headers: HTTPHeaders = [
        .contentType("application/json")
    ]
    
    
    init(config: NetworkConfig) {
        self.config = config
    }
    
    
    func post<T: Codable, R: Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        guard let data = try? jsonEncoder.encode(model) else { return nil }
        guard let dataString = String(data: data, encoding: .utf8) else { return nil }
        
        let request = AF.request("\(config.baseUrl)\(path.rawValue)",
                                 method: .post,
                                 parameters: convertToDictionary(text: dataString),
                                 encoding: JSONEncoding.default,
                                 headers: headers)
            .validate()
            .serializingDecodable(T.self)
        
        let result = await request.response
        guard let value = result.value else {
            print("ERROR: \(String(describing: result.error))")
            return nil
        }
        return value
    }
    
    func get<T: Codable>(path: NetworkPath, type: T.Type) async -> T? {
        print("\(config.baseUrl)\(path.rawValue)")
        print("Headers: \(headers)")
        let request = AF.request("\(config.baseUrl)\(path.rawValue)",
                                 method: .get,
                                 headers: headers)
            .validate()
            .serializingDecodable(T.self)
        
        let response = await request.response
        print("🔗 Response: \(response)")
        guard let value = response.value else {
            print("ERROR: \(String(describing: response.error))")
            return nil
        }
        
        return value
        
    }
    
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
