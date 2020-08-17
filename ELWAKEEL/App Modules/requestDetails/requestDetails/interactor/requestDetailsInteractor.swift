//
//  requestDetailsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestDetailsInteractor: class {
	var parameters: [String: Any]? { get set }
    func cancelRequest(id: Int, reason: String)
    func get_request_details(request_id: Int)


}

class requestDetailsInteractor: IrequestDetailsInteractor {
    func get_request_details(request_id: Int) {
        
        worker?.request_details(request_id: request_id, complition: { (success, error, response) in
            if success{
                if let response = response {
                self.presenter?.assign_request(request: response)
                }
                else{
                    print("No response found")
                }
                
            }
            else{
                print("error\(String(describing: error?.message))")
            }
            
            
        })
       
    }
    
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
    var presenter: IrequestDetailsPresenter?
    var worker: IrequestDetailsWorker?
    var parameters: [String: Any]?

    init(presenter: IrequestDetailsPresenter, worker: IrequestDetailsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
