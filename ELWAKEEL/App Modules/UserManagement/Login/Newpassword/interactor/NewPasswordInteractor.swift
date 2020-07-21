//
//  NewPasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol INewPasswordInteractor: class {
	var parameters: [String: Any]? { get set }
    func updatePassword(password: String, phone: String)
}

class NewPasswordInteractor: INewPasswordInteractor {
    
    
    
    var presenter: INewPasswordPresenter?
    var worker: INewPasswordWorker?
    var parameters: [String: Any]?

    init(presenter: INewPasswordPresenter, worker: INewPasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    func updatePassword(password: String, phone: String) {
        worker?.updatePasswordAPI(password: password, Phone: phone, complition: { (error, success, responseData) in
            
            if error != nil{
                print("error1")
                self.presenter?.showAlert(title: Localization.errorLBL, msg: Localization.thereiserror)
                
            }
            
                if responseData?.count == 0{
                    print("error2")
                    self.presenter?.showAlert(title: Localization.information, msg: Localization.passwordUpdated)
                    self.presenter?.GoHome()
                    
                }
                else{
                    print("error3")
                       self.presenter?.showAlert(title: Localization.errorLBL, msg: Localization.thereiserror)
                    }
})
}
}
