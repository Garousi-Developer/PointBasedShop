import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)
        -> Bool
    {
        launchApp()
        
        return true
    }
}

extension AppDelegate {
    func launchApp(relaunch: Bool = false) {
        languageIsPersian ? switchToPersian() : switchToEnglish()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaults.standard.string(forKey: "token") != nil {
            if relaunch {
                UIView.transition(
                    with: window!,
                    duration: 2 * durations(.interaction),
                    options: .transitionCrossDissolve,
                    animations: {
                        self.window!.rootViewController = viewController(ofNavigationDestination: .tabs)
                    },
                    completion: nil
                )
            }
            else {
                window!.rootViewController = viewController(ofNavigationDestination: .tabs)
            }
        }
        else {
            if relaunch {
                UIView.transition(
                    with: window!,
                    duration: 2 * durations(.interaction),
                    options: .transitionCrossDissolve,
                    animations: {
                        self.window!.rootViewController = viewController(ofNavigationDestination: .login)
                    },
                    completion: nil
                )
            }
            else {
                window!.rootViewController = viewController(ofNavigationDestination: .login)
            }
        }
        window!.makeKeyAndVisible()
    }
}
