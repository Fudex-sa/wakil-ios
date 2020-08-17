//
//  Accept_RequestInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IAccept_RequestInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_offers(id: Int)
}

class Accept_RequestInteractor: IAccept_RequestInteractor {
    func get_offers(id: Int) {
        worker?.get_offers(id: id, complition: { (success, error, response) in
            if success{
                if let response = response{
                    self.presenter?.assign_offers(offers: response)

                }
                else{
                    print("no response found")
                }
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    var presenter: IAccept_RequestPresenter?
    var worker: IAccept_RequestWorker?
    var parameters: [String: Any]?

    init(presenter: IAccept_RequestPresenter, worker: IAccept_RequestWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
