//
//  UIViewController+EX.swift
//  BaseIOS
//
//  Created by Mabdu on 01/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import SwiftyGif

protocol LoadingContract: NSObjectProtocol {
    var imageContainerLoader: UIImageView? { get set }
    var loaderGIF: UIImage { get set }
    func startLoading()
    func stopLoading()
}

extension BaseController: LoadingContract {
    func startLoading() {
//        LottieAnimate.instance.loadingView = view
//        LottieAnimate.instance.startLoading()
//        self.navigationController?.navigationBar.isUserInteractionEnabled = false
//        self.tabBarController?.tabBar.isUserInteractionEnabled = false
//        self.view.isUserInteractionEnabled = false
        if imageContainerLoader?.superview != nil && imageContainerLoader?.superview == view {
            return
        } else {
            imageContainerLoader?.removeFromSuperview()
        }
        imageContainerLoader = UIImageView()
        view.addSubview(imageContainerLoader ?? UIView())
        imageContainerLoader?.addWidthConstraint(toView: nil, constant: 200)
        imageContainerLoader?.addHeightConstraint(toView: nil, constant: 200)
        imageContainerLoader?.addCenterXConstraint(toView: view)
        imageContainerLoader?.addCenterYConstraint(toView: view)
        do {
            loaderGIF = try UIImage(gifName: "Loading-Light.gif")
            if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
                loaderGIF = try UIImage(gifName: "Loading-Dark.gif")
            }
            imageContainerLoader?.setGifImage(loaderGIF)
        } catch {
            print(error.localizedDescription)
        }
        self.view.isUserInteractionEnabled = false

//        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
//        progress.mode = .annularDeterminate
//        progress.isUserInteractionEnabled = false
//        self.view.isUserInteractionEnabled = false
//        progress.show(animated: true)
    }
    func stopLoading() {
//        LottieAnimate.instance.stopLoading()
//        self.navigationController?.navigationBar.isUserInteractionEnabled = true
//        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        //MBProgressHUD.hide(for: self.view, animated: true)
        imageContainerLoader?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        
    }
}

//extension BaseCollectionViewCell: LoadingContract {
//    func startLoading() {
//        if imageContainerLoader?.superview != nil && imageContainerLoader?.superview == contentView {
//            return
//        } else {
//            imageContainerLoader?.removeFromSuperview()
//        }
//        contentView.addSubview(imageContainerLoader ?? UIView())
//        imageContainerLoader?.addWidthConstraint(toView: nil, constant: 200)
//        imageContainerLoader?.addHeightConstraint(toView: nil, constant: 200)
//        imageContainerLoader?.addCenterXConstraint(toView: contentView)
//        imageContainerLoader?.addCenterYConstraint(toView: contentView)
//        do {
//            loaderGIF = try UIImage(gifName: "Loading-Light.gif")
//            if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
//                loaderGIF = try UIImage(gifName: "Loading-Dark.gif")
//            }
//            imageContainerLoader?.setGifImage(loaderGIF)
//        } catch {
//            print(error.localizedDescription)
//        }
//        self.contentView.isUserInteractionEnabled = false
//    }
//    func stopLoading() {
//        imageContainerLoader?.removeFromSuperview()
//        self.contentView.isUserInteractionEnabled = true
//        
//    }
//}
extension BaseTableViewCell: LoadingContract {
    func startLoading() {
        if imageContainerLoader?.superview != nil && imageContainerLoader?.superview == contentView {
            return
        } else {
            imageContainerLoader?.removeFromSuperview()
        }
        contentView.addSubview(imageContainerLoader ?? UIView())
        imageContainerLoader?.addWidthConstraint(toView: nil, constant: 200)
        imageContainerLoader?.addHeightConstraint(toView: nil, constant: 200)
        imageContainerLoader?.addCenterXConstraint(toView: contentView)
        imageContainerLoader?.addCenterYConstraint(toView: contentView)
        do {
            loaderGIF = try UIImage(gifName: "Loading-Light.gif")
            if UD.APP_MODE == ThemeApp.Mode.dark.rawValue {
                loaderGIF = try UIImage(gifName: "Loading-Dark.gif")
            }
            imageContainerLoader?.setGifImage(loaderGIF)
        } catch {
            print(error.localizedDescription)
        }
        self.contentView.isUserInteractionEnabled = false
    }
    func stopLoading() {
        imageContainerLoader?.removeFromSuperview()
        self.contentView.isUserInteractionEnabled = true
        
    }
}
