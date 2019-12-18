import UIKit
@testable import BookSeeker

final class SearchInputLogicDummy: UIView, SearchInputLogic {
    var delegate: SearchViewDelegate?
    
    func startLoading() {}
    
    func stopLoading() {}
    
    func display(content: SearchView.DisplayContent) {}
}
