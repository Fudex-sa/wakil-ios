//
//  HomePresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomePresenter: class {
	// do someting...
    func assingRequest(requeste: HomeModel.requests)
    func assignAdvertizing(advertizing: [HomeModel.Advertising])
}

class HomePresenter: IHomePresenter {
    func assignAdvertizing(advertizing: [HomeModel.Advertising]) {
        view?.assignAdvertizing(advertizing: advertizing)
    }
    
    func assingRequest(requeste: HomeModel.requests) {
        view?.assignRequests(requests: requeste)
        
        print("presenter count \(requeste.data.count)")

    }
    
    
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
}
