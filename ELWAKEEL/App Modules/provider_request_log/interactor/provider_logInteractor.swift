//
//  provider_logInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iprovider_logInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_Logs()
}

class provider_logInteractor: Iprovider_logInteractor {
    func get_Logs() {
        worker?.get_records(complition: { (success, error, reponse) in
            if success{
                if let reponse = reponse{
                    self.presenter?.assign_logs(logs: reponse)
                    
                }
                else
                {
                    print("No response founded")
                }
            }
            
            else{
                print("error\(String(describing: error?.message))")
                
            }
        })
    }
    
    var presenter: Iprovider_logPresenter?
    var worker: Iprovider_logWorker?
    var parameters: [String: Any]?

    init(presenter: Iprovider_logPresenter, worker: Iprovider_logWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
