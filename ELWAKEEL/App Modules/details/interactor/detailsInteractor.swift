//
//  detailsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IdetailsInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_request_details(request_id: Int)

}

class detailsInteractor: IdetailsInteractor {
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
    
    var presenter: IdetailsPresenter?
    var worker: IdetailsWorker?
    var parameters: [String: Any]?

    init(presenter: IdetailsPresenter, worker: IdetailsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
