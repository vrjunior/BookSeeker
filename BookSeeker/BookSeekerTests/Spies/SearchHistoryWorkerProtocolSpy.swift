@testable import BookSeeker

final class SearchHistoryWorkerProtocolSpy: SearchHistoryWorkerProtocol {
    
    // Stub
    var fetchHistoryToBeReturn: [String] = []

    // Spy
    private(set) var saveCalled = false
    private(set) var termPassed: String?
    
    private(set) var fetchHistoryCalled = false
    
    func save(term: String) {
        saveCalled = true
        termPassed = term
    }
    
    func fetchHistory() -> [String] {
        fetchHistoryCalled = true
        return fetchHistoryToBeReturn
    }
}
