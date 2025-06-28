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

enum NetworkPath: String {
    case PIResidence = "api/PersonalInfo/residence"
    case PIName = "api/PersonalInfo/name"
    case PIAdress = "api/PersonalInfo/adress"
    case PIEmail = "api/PersonalInfo/email"
    case PIPasscode = "api/PersonalInfo/passcode"
    case Register = "api/Auth/register"
    case Login = "api/Auth/login"
    static let baseUrl: String = "http://localhost:5245/"
}

protocol INetworkManager {
    func get<T: Codable>(path: NetworkPath,method: HTTPMethod, type: T.Type)
    func post<T: Codable, R: Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T?
    var config: NetworkConfig { get set }
}

extension NetworkManager {
    static let networkManager: INetworkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseUrl))
}

class NetworkManager: INetworkManager {
    var config: NetworkConfig
    let headers: HTTPHeaders = [
        .contentType("application/json")  // Burada içerik türünü belirtiyoruz
    ]
    
    
    init(config: NetworkConfig) {
        self.config = config
    }
    
    func get<T>(path: NetworkPath, method: Alamofire.HTTPMethod, type: T.Type) where T : Decodable, T : Encodable {
        
    }
    
    func post<T: Codable, R: Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        guard let data = try? jsonEncoder.encode(model) else { return nil }
        guard let dataString = String(data: data, encoding: .utf8) else { return nil }
        
        var request = AF.request("\(config.baseUrl)\(path.rawValue)",
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
