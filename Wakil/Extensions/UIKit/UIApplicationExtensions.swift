import UIKit

extension UIApplication {
    static func topViewController(base: UIViewController? = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    static func topMostController() -> UIViewController {
        guard var topController: UIViewController = UIApplication.keyWindow?.rootViewController else { return UIViewController() }
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension UIApplication {
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    static var keyWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
}
