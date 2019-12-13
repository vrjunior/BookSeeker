import UIKit

final class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = false
    }
}
