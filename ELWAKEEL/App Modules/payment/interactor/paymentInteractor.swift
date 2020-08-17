//
//  paymentInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IpaymentInteractor: class {
	var parameters: [String: Any]? { get set }
    func accept_offer(bank_name: String, iban_num: Int,
    offer_num: Int)
}

class paymentInteractor: IpaymentInteractor {
    func accept_offer(bank_name: String, iban_num: Int, offer_num: Int) {
        
        
        worker?.accept_offer(bank_name: bank_name, iban_num: iban_num, offer_num: offer_num, complition: { (success, error, response) in
            if success{
                
               print("success")
                self.presenter?.go_request_details()
                
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
        
    }
    
    
    var presenter: IpaymentPresenter?
    var worker: IpaymentWorker?
    var parameters: [String: Any]?

    init(presenter: IpaymentPresenter, worker: IpaymentWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
