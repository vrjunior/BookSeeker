import XCTest
@testable import BookSeeker

final class SearchHistoryWorkerTests: XCTestCase {
    private let userDefaultsDataStoreSpy = UserDefaultsDataStoreProtocolSpy()
    private lazy var sut = SearchHistoryWorker(dataStore: userDefaultsDataStoreSpy)
    
    func test_save_givenHaveTermsSalvedEqual_shouldReplaceEqualTerms() {
        let termsSaved = ["Term1", "Term2", "Term3", "Term4"]
        userDefaultsDataStoreSpy.getValueToBeReturned = termsSaved
        
        sut.save(term: "Term2")
        
        XCTAssertTrue(userDefaultsDataStoreSpy.setCalled)
        XCTAssertEqual(userDefaultsDataStoreSpy.keyPassed, .searchHistory)
        XCTAssertEqual(userDefaultsDataStoreSpy.valuePassed as? [String], ["Term2", "Term1", "Term3", "Term4"])
    }
    
    func test_save_givenNoPreviousTerms_shouldCallSetTerm() {
        userDefaultsDataStoreSpy.getValueToBeReturned = nil
        
        sut.save(term: "Term2")
        
        XCTAssertTrue(userDefaultsDataStoreSpy.setCalled)
        XCTAssertEqual(userDefaultsDataStoreSpy.valuePassed as? [String], ["Term2"])
    }
    
    func test_fetchHistory_shouldCallGetPassingCorrectKey() {
        _ = sut.fetchHistory()
        
        XCTAssertTrue(userDefaultsDataStoreSpy.getCalled)
        XCTAssertEqual(userDefaultsDataStoreSpy.keyPassed, .searchHistory)
    }
}
