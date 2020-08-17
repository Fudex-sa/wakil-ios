//
//  editRequestInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestInteractor: class {
	var parameters: [String: Any]? { get set }
    func getRequest_Datails(id: Int)
    func cancelRequest(id: Int, reason: String)
}

class editRequestInteractor: IeditRequestInteractor {
    func cancelRequest(id: Int, reason: String) {
        worker?.cancelRequest(id: id, reason: reason, complition: { (success, error, response) in
            if success{
                self.presenter?.cancel()
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    
    
    func getRequest_Datails(id: Int) {
        worker?.getRqeques(id: id, complition: { (success, error, respnse) in
            if success{
                self.presenter?.asgniRequest(requestDetails: respnse!)
            }
            else{
                print("error \(String(describing: error?.message))")
            }
        })
    }
    
    var presenter: IeditRequestPresenter?
    var worker: IeditRequestWorker?
    var parameters: [String: Any]?

    init(presenter: IeditRequestPresenter, worker: IeditRequestWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
