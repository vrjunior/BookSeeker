import Foundation
import Alamofire

protocol NetworkProtocol {
    func requestCodable<T: Decodable>(
        _ networkRequest: NetworkRequest,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?,
        completion: @escaping (Swift.Result<T, Error>) -> Void
    )
}

final class Network {
    public static let shared = Network()
    
    private let sessionManager: SessionManager
    
    private init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionManager = SessionManager(configuration: sessionConfiguration)
    }
    
    // MARK: - Private methods
}

// MARK: - NetworkProtocol

extension Network: NetworkProtocol {
    func requestCodable<T: Decodable>(
        _ networkRequest: NetworkRequest,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?,
        completion: @escaping (Swift.Result<T, Error>) -> Void) {
    
        do {
            let urlRequest = try networkRequest.toRequest()
        
            sessionManager.request(urlRequest).response { response in
                
                do {
                    guard let data = response.data else {
                        throw NetworkError.noData
                    }
                    
                    let jsonDecoder = JSONDecoder()
                    if let dateDecodingStrategy = dateDecodingStrategy {
                        jsonDecoder.dateDecodingStrategy = dateDecodingStrategy
                    }
                    
                    let value = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(value))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
