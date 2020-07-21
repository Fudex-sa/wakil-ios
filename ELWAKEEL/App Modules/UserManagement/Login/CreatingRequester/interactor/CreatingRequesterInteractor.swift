//
//  CreatingRequesterInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import  LocalizationFramework

protocol ICreatingRequesterInteractor: class {
	var parameters: [String: Any]? { get set }
    func signUP(phone: String)
}

class CreatingRequesterInteractor: ICreatingRequesterInteractor {
   
    
    
    
    var presenter: ICreatingRequesterPresenter?
    var worker: ICreatingRequesterWorker?
    var parameters: [String: Any]?

    init(presenter: ICreatingRequesterPresenter, worker: ICreatingRequesterWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    
    func signUP(phone: String) {
      
        worker?.signUpAPI(phone: phone, complition: { (error, success, responseData) in
            
            if error != nil{
                self.presenter?.showAlert(title: Localization.errorLBL, msg: error?.message ?? "Error")            }
            else{
                if let response = responseData{
                    self.presenter?.goVerification(type: "client", id: response.id!)
                    self.presenter?.assignModel(newClient: response)
                }
            }
            
        })
    }
}
