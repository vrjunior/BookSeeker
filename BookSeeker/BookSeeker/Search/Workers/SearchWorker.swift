protocol SearchWorkerProtocol {
    func performSearchBooks(term: String, completion: @escaping (Result<SearchBookResponse, Error>) -> Void)
}

final class SearchWorker {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network.shared) {
        self.network = network
    }
}

// MARK: - SearchWorkerProtocol

extension SearchWorker: SearchWorkerProtocol {
    func performSearchBooks(term: String, completion: @escaping (Result<SearchBookResponse, Error>) -> Void) {
        let request = BookSearchRequest(term: term)
        network.requestCodable(request, dateDecodingStrategy: .iso8601, completion: completion)
    }
}
