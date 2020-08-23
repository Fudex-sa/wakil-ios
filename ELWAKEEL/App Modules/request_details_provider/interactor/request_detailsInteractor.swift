//
//  request_detailsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Irequest_detailsInteractor: class {
	var parameters: [String: Any]? { get set }
    
    func get_request_details(request_id: Int)
    func cancelRequest(request_id: Int, reason: String)
    func  done_request(request_id: Int)
    func rating(rate: Int, user_id: Int, request_id: Int)
    
}

class request_detailsInteractor: Irequest_detailsInteractor {
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
    
    
    
    func done_request(request_id: Int) {
        worker?.done_request(request_id: request_id, complition: { (success, error, response) in
            if success{
                self.presenter?.evaluate_client()
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    func cancelRequest(request_id: Int, reason: String) {
        worker?.apology_request(request_id: request_id, reason: reason, complition: { (success, error, response) in
            if success{
                self.presenter?.cancel()
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
    
    var presenter: Irequest_detailsPresenter?
    var worker: Irequest_detailsWorker?
    var parameters: [String: Any]?

    init(presenter: Irequest_detailsPresenter, worker: Irequest_detailsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
