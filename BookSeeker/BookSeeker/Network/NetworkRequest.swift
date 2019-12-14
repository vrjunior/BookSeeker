import Foundation
import Alamofire

protocol NetworkRequest {
    var baseURL: URL? { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension NetworkRequest {
    var headers: HTTPHeaders? {
        return nil
    }
    
    func toRequest() throws -> URLRequestConvertible {
        guard let urlPathComponent = URLComponents(string: path) else {
           throw NetworkRequestError.invalidURL
        }
        
        guard let url = urlPathComponent.url(relativeTo: baseURL) else {
            throw NetworkRequestError.invalidURL
        }
        
        let urlRequest = try URLRequest(url: url, method: method, headers: headers)
        
        return try encoding.encode(urlRequest, with: parameters)
   }
}

protocol ItunesRequest: NetworkRequest {}

extension ItunesRequest {
    var baseURL: URL? {
        return URL(string: "https://itunes.apple.com")
    }
}

enum NetworkRequestError: Error {
    case invalidURL
}
