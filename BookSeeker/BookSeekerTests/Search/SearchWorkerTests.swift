import XCTest
@testable import BookSeeker

final class SearchWorkerTests: XCTestCase {
    private let networkSpy = NetworkProtocolSpy()
    private lazy var sut = SearchWorker(network: networkSpy)
    
    func test_performSearchBooks_shouldCallRequestCodablePassingCorrectRequest() {
        let term = "Some term"
        
        sut.performSearchBooks(term: term) { _ in }
        
        XCTAssertTrue(networkSpy.requestCodableCalled)
        XCTAssertTrue(networkSpy.networkRequestPassed is BookSearchRequest)
    }
}
