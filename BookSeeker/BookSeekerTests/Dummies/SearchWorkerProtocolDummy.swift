@testable import BookSeeker

final class SearchWorkerProtocolDummy: SearchWorkerProtocol {
    func performSearchBooks(term: String, completion: @escaping (Result<SearchBookResponse, Error>) -> Void) {}
}
