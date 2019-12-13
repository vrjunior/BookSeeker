import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindowAndRootView()
        
        return true
    }
    
    private func setupWindowAndRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let searchViewController = SearchConfigurator().createScene()
        window?.rootViewController = searchViewController
        window?.makeKeyAndVisible()
    }
}

