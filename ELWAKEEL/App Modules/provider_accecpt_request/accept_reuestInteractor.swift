//
//  accept_reuestInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iaccept_reuestInteractor: class {
	var parameters: [String: Any]? { get set }
    func craete_offer(price: Double, required_paper: String, duration: String, service_id: Int)
}

class accept_reuestInteractor: Iaccept_reuestInteractor {
    func craete_offer(price: Double, required_paper: String, duration: String, service_id: Int) {
        worker?.create_offer(price: price, required_paper: required_paper, duration: duration, service_id: service_id, complition: { (success, error, response) in
            if success{
                if response != nil{
                   self.presenter?.go_home()
                    
                }
                else{
                    print("response Not Founded")
                }
            }
            else{
                print("error\(error?.message)")
            }
        })
    }
    
    var presenter: Iaccept_reuestPresenter?
    var worker: Iaccept_reuestWorker?
    var parameters: [String: Any]?

    init(presenter: Iaccept_reuestPresenter, worker: Iaccept_reuestWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
