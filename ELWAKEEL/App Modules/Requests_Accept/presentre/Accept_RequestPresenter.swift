//
//  Accept_RequestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IAccept_RequestPresenter: class {
	// do someting...
    func assign_offers(offers: Accept_RequestModel.offer)
}

class Accept_RequestPresenter: IAccept_RequestPresenter {
    func assign_offers(offers: Accept_RequestModel.offer) {
        view?.assign_offer(offers: offers)
    }
    
	weak var view: IAccept_RequestViewController?
	
	init(view: IAccept_RequestViewController?) {
		self.view = view
	}
}
