@testable import BookSeeker

final class SearchHistoryWorkerProtocolDummy: SearchHistoryWorkerProtocol {
    func save(term: String) {}
    
    func fetchHistory() -> [String] {
        return []
    }
}
