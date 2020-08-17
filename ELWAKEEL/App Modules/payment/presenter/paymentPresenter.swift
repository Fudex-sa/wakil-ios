//
//  paymentPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IpaymentPresenter: class {
    func go_request_details()
	// do someting...
}

class paymentPresenter: IpaymentPresenter {
    func go_request_details() {
        view?.go_request_details()
    }
    
	weak var view: IpaymentViewController?
	
	init(view: IpaymentViewController?) {
		self.view = view
	}
}
