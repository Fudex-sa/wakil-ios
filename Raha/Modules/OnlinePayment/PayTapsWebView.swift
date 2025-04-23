//
//  NoonWebView.swift
//  Mutsawiq
//
//  Created by rh.com.sa on 14/07/2021.
//  Copyright © 2021 com.Rowaad. All rights reserved.
//

import Foundation
import WebKit
import FirebaseAnalytics
class PayTapsWebView: BaseController {
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL?
    weak var delegate: PayTapsDelegate?
    weak var dataSource: PayTapsDataSource?
    var successed: Bool?
    var orderID: Int?
    var timer: TimeHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if !successed {
//            self.delegate?.payTaps(nil, fail: true)
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.stopTimer()
        timer = nil
        if successed == nil {
            self.callTransactionEvent(for: "cancel")
            self.delegate?.payTaps(nil, cancel: true)
            return
        }
        if successed == true {
            self.callTransactionEvent(for: "success")
            self.delegate?.payTaps(nil, didPay: orderID ?? 0)
        } else {
            self.callTransactionEvent(for: "failed")
            self.delegate?.payTaps(nil, fail: true)
        }
    }
    func setup() {
        if let paytapURL = dataSource?.payTaps(nil, URL: nil) {
            guard let url = URL(string: paytapURL) else { return }
            self.url = url
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
            startLoading()
            makeTimer()
        } else {
            self.navigationController?.popViewController(animated: true)
            //self.dismiss(animated: true, completion: nil)
            self.callTransactionEvent(for: "failed")
            self.delegate?.payTaps(nil, fail: true)
        }
    }
    func makeTimer() {
        let seconds = 60 * 15
        timer = .init(seconds: 1, numberOfCycle: seconds, closure: { cycle in
            if cycle == 1 && self.successed == nil {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    func callTransactionEvent(for state: String) {
        let eventParamters: [String: String] = [
            AnalyticsParameterMethod: "CREDIT_CARD",
            AnalyticsParameterTransactionID: orderID?.string ?? "",
            "transaction_states": state
        ]
    }
}

extension PayTapsWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if(navigationAction.navigationType != .backForward && navigationAction.navigationType != .reload) {
            if navigationAction.request.url != nil {
                guard let url = navigationAction.request.url?.absoluteString else {
                    decisionHandler(.allow)
                    return
                }
                if let successURL = dataSource?.payTaps(nil, successURL: nil), let failURL = dataSource?.payTaps(nil, failURL: nil) {
                    print(url)
                    if url.lowercased().contains(successURL.lowercased()) {
                        orderID = 22
                        self.webView.isHidden = true
                        self.successed = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            // Your action or code here
                            self.navigationController?.popViewController(animated: true)
                        }
                        //self.dismiss(animated: true, completion: nil)
                    } else if url.lowercased().contains(failURL.lowercased()) {
                        self.successed = false
                        self.webView.isHidden = true
                        self.navigationController?.popViewController(animated: true)
                        //self.dismiss(animated: true, completion: nil)
                    }
                }
                decisionHandler(.allow)
                return
            }
            decisionHandler(.allow)
            return
        } else {
            decisionHandler(.allow)
            return
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoading()
        let javascript = "document.getElementsByTagName('footer')[0].style.display='none'; " + "document.getElementsByTagName('main')[0].getElementsByClassName('text-center pt-2')[0].style.display='none';"
        
        webView.evaluateJavaScript(javascript) { result, error in
            
        }
    }
}
