//
//  ForgetpasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IForgetpasswordInteractor: class {
	var parameters: [String: Any]? { get set }
    func forgetPassword(phone: String)
}

class ForgetpasswordInteractor: IForgetpasswordInteractor {
   
    
    
    var presenter: IForgetpasswordPresenter?
    var worker: IForgetpasswordWorker?
    var parameters: [String: Any]?

    init(presenter: IForgetpasswordPresenter, worker: IForgetpasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    func forgetPassword(phone: String) {
        
        worker?.forgetPasswordAPI(phone: phone, Complition: { (error, success,reponse)  in
            if error != nil{
                self.presenter?.showAlert(title: Localization.errorLBL, msg: (error?.message)!)
            }
            else{
                if let reponse = reponse {
                    if reponse.count > 0{
                       self.presenter?.showAlert(title: Localization.errorLBL, msg: (error?.message)!)
                    }
                    else{
                        self.presenter?.goVerification(params: ["phone": phone])

                    }
                }
            }
            
                
            }
                    )
        
    }
    
   
}
