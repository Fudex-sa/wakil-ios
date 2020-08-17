//
//  walletInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IwalletInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_wallet()
    
}

class walletInteractor: IwalletInteractor {
    func get_wallet() {
        worker?.get_wallet(complition: { (succsee, error, response) in
            if succsee{
                if let response = response{
                   self.presenter?.assign_walllet(wallet: response)
                }
                else{
                    print("No wallet founded")
                }
                
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    var presenter: IwalletPresenter?
    var worker: IwalletWorker?
    var parameters: [String: Any]?

    init(presenter: IwalletPresenter, worker: IwalletWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
