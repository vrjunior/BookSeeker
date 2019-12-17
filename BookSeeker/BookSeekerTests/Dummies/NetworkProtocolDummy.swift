import Foundation

@testable import BookSeeker

final class NetworkProtocolDummy: NetworkProtocol {
    func requestCodable<T>(_ networkRequest: NetworkRequest, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {}
}
