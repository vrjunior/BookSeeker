protocol SearchHistoryWorkerProtocol {
    func save(term: String)
    func fetchHistory() -> [String]
}

final class SearchHistoryWorker {
    private let dataStore: UserDefaultsDataStoreProtocol
    
    init(dataStore: UserDefaultsDataStoreProtocol = UserDefaultsDataStore()) {
        self.dataStore = dataStore
    }
}

// MARK: - SearchHistoryWorkerProtocol

extension SearchHistoryWorker: SearchHistoryWorkerProtocol {
    func save(term: String) {
        var previousHistory = fetchHistory()
        previousHistory.removeAll { $0.lowercased() == term.lowercased() }
        previousHistory.insert(term, at: 0)
        dataStore.set(value: previousHistory, key: .searchHistory)
    }
    
    func fetchHistory() -> [String] {
        return dataStore.get(.searchHistory) ?? []
    }
}
