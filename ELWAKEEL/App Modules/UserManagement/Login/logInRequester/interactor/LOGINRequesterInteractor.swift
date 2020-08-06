//
//  LOGINRequesterInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol ILOGINRequesterInteractor: class {
	var parameters: [String: Any]? { get set }
    func dologin(phone: String, password:String, type: String)
}

class LOGINRequesterInteractor: ILOGINRequesterInteractor {
  
    
    var presenter: ILOGINRequesterPresenter?
    var worker: ILOGINRequesterWorker?
    var parameters: [String: Any]?

    init(presenter: ILOGINRequesterPresenter, worker: ILOGINRequesterWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    
    func dologin(phone: String, password: String, type: String) {
       
        print("type\(type)")
        worker?.loginFromApi(phone: phone, password: password, type: type, complition: { (error, success, response) in
            if success == true{
                self.presenter?.getUser(user: response!)
                let userdefults = UserDefaults.standard
                userdefults.set(response?.type, forKey: "type")
                userdefults.set(response?.accessToken, forKey: "token")
                userdefults.set(response?.user.email, forKey: "email")
                userdefults.set(response?.user.name, forKey: "name")
                userdefults.set(response?.user.id, forKey: "id")
                userdefults.set(response?.user.phone, forKey: "phone")
                userdefults.set(true, forKey: "login")
                self.presenter?.navigateHome()

            }
            if error != nil{
                self.presenter?.showErrorAlert(title: Localization.errorLBL , msg: error?.message ?? "Error")
                print("interactor3")
            }
            
        })
    }
}
