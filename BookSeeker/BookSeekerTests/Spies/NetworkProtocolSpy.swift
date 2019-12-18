import Foundation
@testable import BookSeeker

final class NetworkProtocolSpy: NetworkProtocol {
    private(set) var requestCodableCalled = false
    private(set) var networkRequestPassed: NetworkRequest?
    private(set) var dateDecodingStrategyPassed: JSONDecoder.DateDecodingStrategy?
    func requestCodable<T: Decodable>(
        _ networkRequest: NetworkRequest,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?,
        completion: @escaping (Swift.Result<T, Error>) -> Void
    ) {
        requestCodableCalled = true
        networkRequestPassed = networkRequest
        dateDecodingStrategyPassed = dateDecodingStrategy
    }
}
