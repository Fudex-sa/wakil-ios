//
//  HomeInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeInteractor: class {
	var parameters: [String: Any]? { get set }
    func getDevertising()
}

class HomeInteractor: IHomeInteractor {
    func getDevertising() {
        worker?.getAdvertising(complition: { (success, error, data) in
            print(data)
        })
       
    }
    
    var presenter: IHomePresenter?
    var worker: IHomeWorker?
    var parameters: [String: Any]?

    init(presenter: IHomePresenter, worker: IHomeWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
