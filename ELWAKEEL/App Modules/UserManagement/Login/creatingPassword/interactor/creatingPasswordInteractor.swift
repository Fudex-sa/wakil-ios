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
                    let userdefults = UserDefaults.standard
                    userdefults.set(response.type, forKey: "type")
                    userdefults.set(response.accessToken, forKey: "token")
                    userdefults.set(response.user.email, forKey: "email")
                    userdefults.set(response.user.name, forKey: "name")
                    userdefults.set(response.user.id, forKey: "id")
                    userdefults.set(response.user.phone, forKey: "phone")
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
