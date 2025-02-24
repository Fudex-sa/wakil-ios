//
//  CoreViewModel.swift
//  BaseIOS
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import Foundation
import Alamofire
// MARK: - ...  Base ViewModel
class BaseViewModel: NSObject, ViewModelProtocol, ViewModelPaginate, Combining {
    var requests: [DataRequest?] = []
    var subscriptions: Set<Subscriptions> = []
    var error: Publisher<NetworkError> = .init()
    var requestFinished: Publisher<Bool> = .init()
    // MARK: - ...  empty the refrence
    override init() {
        super.init()
        bind()
    }
    deinit {
        removeSubscription()
        removeTasks()
    }
    func publisher() {
        requestFinished.send(true)
    }
    @objc dynamic func bind() {
        
    }
}
