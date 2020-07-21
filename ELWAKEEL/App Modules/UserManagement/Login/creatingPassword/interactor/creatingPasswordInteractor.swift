//
//  creatingPasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IcreatingPasswordInteractor: class {
	var parameters: [String: Any]? { get set }
//    func createPassword()
    func creatingPassword(password: String, type: String, id: Int)
    
    
}

class creatingPasswordInteractor: IcreatingPasswordInteractor {
    func creatingPassword(password: String, type: String, id: Int) {
        worker?.creatingpasswprdAPI(type: type, password: password, id: id, complition: { (error, success, responseData) in
            if error != nil{
                self.presenter?.alert(title: Localization.errorLBL, msg: Localization.thereiserror)
            }
            if success{
                if let response = responseData{
                    self.presenter?.assignClient(client: response)
                    self.presenter?.GoHome()
                    
                }
                else{
                     self.presenter?.alert(title: Localization.errorLBL, msg: Localization.thereiserror)
                }
            }
            else {
                 self.presenter?.alert(title: Localization.errorLBL, msg: Localization.thereiserror)
                
            }
            
        })
    }
    
    
    
    var presenter: IcreatingPasswordPresenter?
    var worker: IcreatingPasswordWorker?
    var parameters: [String: Any]?

    init(presenter: IcreatingPasswordPresenter, worker: IcreatingPasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
