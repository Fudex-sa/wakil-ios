//
//  contactUsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsInteractor: class {
	var parameters: [String: Any]? { get set }
    func contact(email: String, name: String, subject: String, content: String, phone: String)
}

class contactUsInteractor: IcontactUsInteractor {
    func contact(email: String, name: String, subject: String, content: String, phone: String) {
        worker?.contact(name: name, email: email, subject: subject, content: content, phone: phone, complition: { (success, error, resposne) in
            if success{
                if resposne?.count == 0 {
                    self.presenter?.alert()

                }
                else{
                    self.presenter?.errorAlert()
                }
            }
            else{
                print("error\(String(describing: error?.message))")
            
            }
        })
    }
    
    
    
    var presenter: IcontactUsPresenter?
    var worker: IcontactUsWorker?
    var parameters: [String: Any]?

    init(presenter: IcontactUsPresenter, worker: IcontactUsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
