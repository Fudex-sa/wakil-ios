//
//  SwipeRefresh.swift
//  SupportI
//
//  Created by mohamed abdo on 12/21/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

/** vars helper use it **/
private var refreshControlFile: UIRefreshControl?
private var enableSwipeFile: Bool = false
private weak var delegateFile: SwipeRefreshDelegate?
/** vars helper use it **/

/** contract of swipe **/
protocol SwipeRefreshProtocol {
    var refreshControl: UIRefreshControl? { get set }
    var swipeDelegate: SwipeRefreshDelegate? { get set }
    var enableTopSwipe: Bool { get set }
    func swipeTopRefresh()
    func swipeButtomRefresh()
    func stopSwipeButtom()
    func stopSwipeTop()
    func checkSwipeButtom()
    func createIndicator() -> UIActivityIndicatorView
}
/** contract of swipe **/
/** Delegation of swipe **/
@objc protocol SwipeRefreshDelegate: AnyObject {
    @objc func swipeTopEvent()
    func swipeButtomEvent()
}
extension SwipeRefreshDelegate {
    func swipeButtomEvent() {
    }
}
/** Delegation of swipe **/

extension UIScrollView: SwipeRefreshProtocol {
    var swipeDelegate: SwipeRefreshDelegate? {
        get {
            return delegateFile
        }
        set {
            delegateFile = newValue
        }
    }
    var refreshControl: UIRefreshControl? {
        get {
            return refreshControlFile
        } set {
            refreshControlFile = newValue
        }
    }
    var enableTopSwipe: Bool {
        get {
            return enableSwipeFile
        } set {
            enableSwipeFile = newValue
            swipeTopRefresh()
        }
    }
    func checkSwipeButtom() {
        if swipeDelegate != nil {
            if (self.contentOffset.y + self.frame.size.height) >= self.contentSize.height {
                self.swipeButtomRefresh()
            }
        }
    }
    func swipeTopRefresh() {
        if enableTopSwipe {
            refreshControl = UIRefreshControl()
            //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl?.addTarget(swipeDelegate, action: #selector(swipeDelegate?.swipeTopEvent), for: .valueChanged)
            self.addSubview(refreshControl!)
        }
    }
    func swipeButtomRefresh() {
        if self is UITableView {
            let table = self as? UITableView
            let indicator = createIndicator()
            indicator.startAnimating()
            table?.tableFooterView = indicator
            table?.tableFooterView?.isHidden = false
            self.swipeDelegate?.swipeButtomEvent()
        }
    }
    func stopSwipeButtom() {
        if self is UITableView {
            let table = self as? UITableView
            table?.tableFooterView?.isHidden = true
        }
    }
    func stopSwipeTop() {
        self.refreshControl?.endRefreshing()
    }
    func createIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = UIColor.darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }
    func swipeTopRefresh(closure: @escaping (() -> Void)) {
        refreshControl = UIRefreshControl()
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")\
        refreshControl?.actionHandle(ForAction: closure)
        self.addSubview(refreshControl!)
    }
    func swipeButtomRefresh(closure: @escaping (() -> Void)) {
        if (self.contentOffset.y + self.frame.size.height) >= self.contentSize.height {
            if self is UITableView {
                let table = self as? UITableView
                let indicator = createIndicator()
                indicator.startAnimating()
                table?.tableFooterView = indicator
                table?.tableFooterView?.isHidden = false
            }
            closure()
        }
    }
}
extension UIRefreshControl {
    func actionHandle(ForAction action:@escaping () -> Void) {
        self.actionHandleBlock(action: action)
        self.addTarget(self, action: #selector(UIRefreshControl.triggerActionHandleBlock), for: .valueChanged)
    }
   
}

import AVFoundation
protocol Sounder: NSObjectProtocol {
    var refreshPlayer: AVAudioPlayer? { get set }
    func refreshSounder()
}
extension Sounder {
    func refreshSounder() {
        guard
            let urlPath = Bundle.main.path(forResource: "Pull_To_Refresh", ofType: "mp3")
            else { return }
        
        let url = URL(fileURLWithPath: urlPath)
        
        do {
            refreshPlayer = try AVAudioPlayer(contentsOf: url)
            refreshPlayer?.prepareToPlay()
            refreshPlayer?.play()
        } catch {
            print(error)
        }
    }
}
protocol Reloader: Sounder {
    var refreshControl: UIRefreshControl! { get set }
    func swipeTopRefresh(scrollView: UIScrollView, closure: @escaping (() -> Void))
    func stopSwipeTop()
}
extension Reloader {
    func swipeTopRefresh(scrollView: UIScrollView, closure: @escaping (() -> Void)) {
        if refreshControl != nil {
            refreshControl.removeFromSuperview()
        }
        refreshControl = UIRefreshControl()
        refreshControl.actionHandleBlock(action: closure)
        scrollView.addSubview(refreshControl)
        guard let combining = self as? Combining else { return }
        refreshControl.controlEventPublisher(for: .valueChanged).response { _ in
            
        } receiveValue: { [weak self] in
            if self?.refreshControl.isRefreshing == true {
                self?.refreshSounder()
            }
            self?.refreshControl.actionHandleBlock()
        }.store(combining)

    }
    func stopSwipeTop() {
        if refreshControl != nil {
            self.refreshControl.endRefreshing()
        }
    }
}

extension UITableView {
    func bottomLoader() {
        let indicator = createIndicator()
        indicator.startAnimating()
        self.tableFooterView = indicator
        self.tableFooterView?.isHidden = false
    }
    func endLoader() {
        stopSwipeButtom()
    }
}
