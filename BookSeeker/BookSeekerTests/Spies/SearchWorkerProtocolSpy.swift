@testable import BookSeeker

final class SearchWorkerProtocolSpy: SearchWorkerProtocol {
    private(set) var performSearchBooksCalled = false
    private(set) var termPassed: String?
    
    func performSearchBooks(term: String, completion: @escaping (Result<SearchBookResponse, Error>) -> Void) {
        performSearchBooksCalled = true
        termPassed = term
    }
}
