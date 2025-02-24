//
//  Initial.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LottieAnimate: NSObject {
    struct Static {
        static var instance: LottieAnimate?
    }
    class var instance: LottieAnimate {
        if Static.instance == nil {
            Static.instance = LottieAnimate()
        }
        return Static.instance!
    }
    var showLoadingMainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var animationView = AnimationView()
    var animation: Animation?
    var loadingView: UIView?
    override init() {
        super.init()
    }
    init(in view: UIView) {
        super.init()
        loadingView = view
    }
    func animationSplashFile() {
        if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
            animation = Animation.named("splashDark")
            //animation = Animation.filepath("/Users/mohamedabdu/Desktop/Data/mohamedabdu/swift/Wndo-IOS/Wndo/Helpers/UIKit/Loading/Lotti/splashDark.json")
        } else {
            animation = Animation.named("splashLight")
            //animation = Animation.filepath("/Users/mohamedabdu/Desktop/Data/mohamedabdu/swift/Wndo-IOS/Wndo/Helpers/UIKit/Loading/Lotti/splashLight.json")
        }
    }
    func animationLogoFile() {
        if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
            animation = Animation.named("loadingDark")
            //animation = Animation.filepath("/Users/mohamedabdu/Desktop/Data/mohamedabdu/swift/Wndo-IOS/Wndo/Helpers/UIKit/Loading/Lotti/splashDark.json")
        } else {
            animation = Animation.named("loadingLight")
           // animation = Animation.filepath("/Users/mohamedabdu/Desktop/Data/mohamedabdu/swift/Wndo-IOS/Wndo/Helpers/UIKit/Loading/Lotti/splashLight.json")
        }
    }
    func splashLoading(compeletionHandler: ((Bool) -> Void)? = nil) {
        guard let loadingView = loadingView else {
            return
        }
        animationSplashFile()
        DispatchQueue.main.async {
            if loadingView.subviews.contains(self.showLoadingMainView) {
                return
            }
            self.loadingView?.isUserInteractionEnabled = false
            self.showLoadingMainView = .init(frame: loadingView.frame)
            //self.showLoadingMainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            loadingView.addSubview(self.showLoadingMainView)
            self.showLoadingMainView.addSubview(self.animationView)
            self.showLoadingMainView.translatesAutoresizingMaskIntoConstraints = false
            self.showLoadingMainView.heightAnchor.constraint(equalToConstant: loadingView.frame.height).isActive = true
            self.showLoadingMainView.widthAnchor.constraint(equalToConstant: loadingView.frame.width).isActive = true
            self.showLoadingMainView.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 0).isActive = true
            self.showLoadingMainView.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 0).isActive = true
            
            self.animationView.translatesAutoresizingMaskIntoConstraints = false
            self.animationView.heightAnchor.constraint(equalToConstant: loadingView.frame.height/2).isActive = true
            self.animationView.widthAnchor.constraint(equalToConstant: loadingView.frame.width).isActive = true
            self.animationView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor, constant: 0).isActive = true
            self.animationView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: 0).isActive = true
            self.animationView.animation = self.animation

            // Setup our animaiton view
            self.animationView.contentMode = .scaleAspectFill
            // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
            self.animationView.loopMode = .playOnce
            // Now play from 0 to 0.5 progress and loop indefinitely.
            self.animationView.play(completion: compeletionHandler)
            //self.animationView.play(fromProgress: 0, toProgress: 1.1, loopMode: .loop, completion: compeletionHandler)
            //self.animationView.play(fromProgress: 0, toProgress: 1, completion: compeletionHandler)
        }
    }
    func startLoading() {
        guard let view = loadingView else {
            return
        }
        DispatchQueue.main.async {
            if view.subviews.contains(self.showLoadingMainView) {
                return
            }
            view.isUserInteractionEnabled = false
            self.showLoadingMainView = UIView(frame: CGRect(x: view.width / 2 + 25, y: view.height / 2 + 25, width: 50, height: 50))
            self.showLoadingMainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            view.addSubview(self.showLoadingMainView)
            self.showLoadingMainView.addSubview(self.animationView)
            self.showLoadingMainView.translatesAutoresizingMaskIntoConstraints = false
            self.showLoadingMainView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            self.showLoadingMainView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            self.showLoadingMainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            self.showLoadingMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            self.animationView.translatesAutoresizingMaskIntoConstraints = false
            self.animationView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
            self.animationView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
            self.animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
            self.animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
            self.animationView.animation = self.animation
            // Setup our animaiton view
            self.animationView.contentMode = .scaleAspectFit
            // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
            self.animationView.loopMode = .loop
            // Now play from 0 to 0.5 progress and loop indefinitely.
            self.animationView.play(fromProgress: 0, toProgress: 1, completion: nil)
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.showLoadingMainView.removeFromSuperview()
        }
    }
}
