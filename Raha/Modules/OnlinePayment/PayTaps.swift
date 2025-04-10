//
//  HostedVC.swift
//  NoonPaymentDemo
//
//  Created by Islam  on 5/23/21.
//

import UIKit

class PayTaps: NSObject {
    
    weak var delegate: PayTapsDelegate?
    weak var dataSource: PayTapsDataSource?
    init(dataSource: PayTapsDataSource?) {
        super.init()
        self.dataSource = dataSource
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("PAY_PAYMENT"), object: nil)

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("PAY_PAYMENT"), object: nil)
    }
    func present(in view: UIViewController?) {
        let scene = R.storyboard.payTapsWebView.payTapsWebView()!
        scene.delegate = delegate
        scene.dataSource = dataSource
        view?.navigationController?.pushViewController(scene, animated: true)
        //view?.present(scene, animated: true, completion: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.delegate?.payTaps(self, didPay: 0)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("PAY_PAYMENT"), object: nil)
    }

}
