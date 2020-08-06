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
    func getRequest()
   func getDevertising()
    
}

class HomeInteractor: IHomeInteractor {
    func getRequest() {
        worker?.getRqeques(complition: { (success, error, reuests) in
            if  success{
                self.presenter?.assingRequest(requeste: reuests!)
                print("interactor Data count \(reuests?.data.count)")
            }
            
            else{
                print(error?.message ?? "")
            }
        })
    }
    
    func getDevertising() {
        worker?.getAdvertising(complition: { (success, error, data) in
            
            if success {
                self.presenter?.assignAdvertizing(advertizing: data!)
            }
            else{
                print("Error\(String(describing: error?.message))")
            }
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
