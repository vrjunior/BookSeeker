import Foundation
@testable import BookSeeker

final class SearchWorkerProtocolStub: SearchWorkerProtocol {
    var resultToBeReturned: Result<SearchBookResponse, Error> = .failure(NSError())
    
    func performSearchBooks(term: String, completion: @escaping (Result<SearchBookResponse, Error>) -> Void) {
        completion(resultToBeReturned)
    }
}
