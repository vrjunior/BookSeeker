@testable import BookSeeker

final class SearchRoutingLogicSpy: SearchRoutingLogic {
    private(set) var routeToBookDetailsCalled = false
    private(set) var indexPassed: Int?
    
    func routeToBookDetails(with index: Int) {
        routeToBookDetailsCalled = true
        indexPassed = index
    }
}
