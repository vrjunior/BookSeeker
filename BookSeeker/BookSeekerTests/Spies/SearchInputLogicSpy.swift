import UIKit
@testable import BookSeeker

final class SearchInputLogicSpy: UIView, SearchInputLogic {
    var delegate: SearchViewDelegate?
    
    private(set) var startLoadingCalled = false
    private(set) var stopLoadingCalled = false
    private(set) var displayCalled = false
    private(set) var contentPassed: SearchView.DisplayContent?
    
    func startLoading() {
        startLoadingCalled = true
    }
    
    func stopLoading() {
        stopLoadingCalled = true
    }
    
    func display(content: SearchView.DisplayContent) {
        displayCalled = true
        contentPassed = content
    }
}
