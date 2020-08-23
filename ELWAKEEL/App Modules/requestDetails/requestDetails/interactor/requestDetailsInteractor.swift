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
    func rating(rate: Int, user_id: Int, request_id: Int)
    func  done_request(request_id: Int)
    func not_done_request(request_id: Int, reason: String)
}

class requestDetailsInteractor: IrequestDetailsInteractor {
    func not_done_request(request_id: Int, reason: String) {
        worker?.not_done_request(request_id: request_id, reason: reason, complition: { (success, error, response) in
            
            if success{
//                self.presenter?.evaluate_provider()
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    
    
    func done_request(request_id: Int) {
        worker?.done_request(request_id: request_id, complition: { (success, error, response) in
            if success{
                self.presenter?.evaluate_provider()
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    func rating(rate: Int, user_id: Int, request_id: Int) {
        worker?.rate(rating: rate, user_id: user_id, request_id: request_id, complition: { (success, error, response) in
            if success{
                print("token\(UserDefaults.standard.string(forKey: "token"))")
                print("rating \(rate),\(user_id),\(request_id)")
                print("success rateing")
                self.presenter?.done_request()
            }
            else{
                
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
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
