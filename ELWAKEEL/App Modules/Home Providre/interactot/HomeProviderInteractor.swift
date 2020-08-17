//
//  HomeProviderInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_requests()
    func provider_requests()
    func reject_reuest(request_id: Int)
}

class HomeProviderInteractor: IHomeProviderInteractor {
    func reject_reuest(request_id: Int) {
        worker?.reject_request(request_id: request_id, complition: { (success, error, response) in
            if success{
             
                print("rejected")
                self.presenter?.reject_request()
            }
            else{
                print("error\(String(describing: error?.message))")
                
            }
        })
    }
    
    
    func provider_requests() {
        worker?.provider_request(complition: { (success, error, response) in
            
            if success{
                if let response = response{
                   self.presenter?.assign_provider_requests(requests: response)
                }
                else{
                    print("No response founded")
                }
               
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    func get_requests() {
        worker?.naer_requests(complition: { (success, error, response) in
            if success{
               if let response = response{
                    self.presenter?.assign_near_requests(requests: response)

                }
                else{
                    print("No response founded")
                }
            }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    var presenter: IHomeProviderPresenter?
    var worker: IHomeProviderWorker?
    var parameters: [String: Any]?

    init(presenter: IHomeProviderPresenter, worker: IHomeProviderWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
