import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)
        -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            window!.rootViewController = viewController(ofNavigationDestination: .tabs)
        }
        else {
            window!.rootViewController = viewController(ofNavigationDestination: .login)
        }
        
        window!.makeKeyAndVisible()
        
        if let language = UserDefaults.standard.string(forKey: "language") {
            switch language {
            case "persian":
                switchToPersian()
            case "english":
                switchToEnglish()
            default:
                break
            }
        }
        else {
            switchToPersian()
        }
        
        return true
    }
}
