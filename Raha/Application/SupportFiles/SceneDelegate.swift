//
//  SceneDelegate.swift
//  Dibba
//
//  Created by Bakr mohamed on 05/08/2021.
//

import UIKit
import FBSDKCoreKit
import FirebaseDynamicLinks
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
//        if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
//            window?.overrideUserInterfaceStyle = .dark
//        } else {
//            window?.overrideUserInterfaceStyle = .light
//        }
        Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())

//        if UD.onboarding == true {
//            if UD.user == nil || UD.user?.data?.user?.isverified ?? 0 == 0 {
//                Coordinator.instance.restart(storyboard: R.storyboard.loginStoryboard())
//            }else {
//                if UD.user?.data?.user?.club != nil {
//                    UD.club = UD.user?.data?.user?.club
//                }
//                Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
//            }
//        }else {
//            Coordinator.instance.restart(storyboard: R.storyboard.onboardingStoryboard())
//        }

//        Coordinator.instance.restart(storyboard: R.storyboard.matchdetailsStoryboard())
        
//        for family in UIFont.familyNames {
//            print("\(family)")
//
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("\(name)")
//            }
//        }
        
        
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("Your Incoming Custom Scheme URL is \(URLContexts.first?.url.absoluteString)")
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: URLContexts.first?.url){
//            print("dynamiclink: \(url)")
//
//            self.handleIncomingDynamicLink(url: dynamicLink.url?.absoluteString ?? "")
//                   return true
//               }
//       
//        return false
        guard let url = URLContexts.first?.url else {
            return
        }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func substringAfterWord(in text: String, word: String) -> String? {
        // Check if the word exists in the text
        guard let range = text.range(of: word) else {
            return nil // Return nil if the word is not found
        }
        
        // Get the start index of the substring after the word
        let startIndex = range.upperBound
        
        // Extract and return the substring from the start index to the end of the original string
        let substring = text[startIndex...].trimmingCharacters(in: .whitespacesAndNewlines)
        return substring.isEmpty ? nil : substring // Return nil if the substring is empty
    }
}
