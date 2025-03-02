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
    static let instance = LottieAnimate()

       private var showLoadingMainView = UIView()
       private var animationView = LottieAnimationView()  // ✅ Use LottieAnimationView
       private var animation: LottieAnimation?            // ✅ Use LottieAnimation
       private weak var loadingView: UIView?

       private override init() {
           super.init()
       }
       
       func startLoading() {
           guard let view = loadingView else { return }

           DispatchQueue.main.async {
               if view.subviews.contains(self.showLoadingMainView) { return }

               self.showLoadingMainView = UIView(frame: view.bounds)
               self.showLoadingMainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
               view.addSubview(self.showLoadingMainView)

               self.animationView.animation = self.animation
               self.animationView.contentMode = .scaleAspectFit
               self.animationView.loopMode = .loop
               self.animationView.translatesAutoresizingMaskIntoConstraints = false

               self.showLoadingMainView.addSubview(self.animationView)
               
               NSLayoutConstraint.activate([
                   self.animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   self.animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                   self.animationView.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
                   self.animationView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
               ])

               self.animationView.play()
           }
       }
    func stopLoading() {
        DispatchQueue.main.async {
            self.showLoadingMainView.removeFromSuperview()
        }
    }
}
