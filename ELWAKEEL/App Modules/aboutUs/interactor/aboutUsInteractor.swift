//
//  aboutUsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaboutUsInteractor: class {
	var parameters: [String: Any]? { get set }
    func get_contact_info()
}

class aboutUsInteractor: IaboutUsInteractor {
    func get_contact_info() {
        worker?.getContact_info(complition: { (success, error, response) in
            if success{
                self.presenter?.assign_contact_Info(contact_info: response!)
            }
            else{
                print("error\(error?.message)")
            }
        })
    }
    
    var presenter: IaboutUsPresenter?
    var worker: IaboutUsWorker?
    var parameters: [String: Any]?

    init(presenter: IaboutUsPresenter, worker: IaboutUsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
