//
//  sideMenuInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuInteractor: class {
	var parameters: [String: Any]? { get set }
    func getRequest()

}

class sideMenuInteractor: IsideMenuInteractor {
        func getRequest() {
            worker?.getRqeques(complition: { (success, error, reuests) in
                if  success{
                    self.presenter?.assingRequest(requeste: reuests!)
                    print("interactor Data daata \(reuests?.data.count)")
                }
                    
                else{
                    print(error?.message)
                }
            })
    }
    
    var presenter: IsideMenuPresenter?
    var worker: IsideMenuWorker?
    var parameters: [String: Any]?

    init(presenter: IsideMenuPresenter, worker: IsideMenuWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
