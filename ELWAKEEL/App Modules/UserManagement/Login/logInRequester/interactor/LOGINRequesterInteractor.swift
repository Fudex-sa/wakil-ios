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
    func dologin(phone: String, password:String)
}

class LOGINRequesterInteractor: ILOGINRequesterInteractor {
  
    
    var presenter: ILOGINRequesterPresenter?
    var worker: ILOGINRequesterWorker?
    var parameters: [String: Any]?

    init(presenter: ILOGINRequesterPresenter, worker: ILOGINRequesterWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    
    func dologin(phone: String, password: String) {
        Indicator.sharedInstance.showIndicator()
        worker?.loginFromApi(phone: phone, password: password, complition: { (error, success, response) in
            if success == true{
                if let user = response{
                    self.presenter?.getUser(user: user)
                    let userdefults = UserDefaults.standard
                        userdefults.set(response?.type, forKey: "type")
                        userdefults.set(response?.accessToken, forKey: "token")
                        userdefults.set(response?.user.email, forKey: "email")
                        userdefults.set(response?.user.name, forKey: "name")
                        userdefults.set(response?.user.id, forKey: "id")
                        userdefults.set(response?.user.phone, forKey: "phone")
                        userdefults.set(true, forKey: "login")
                        userdefults.set(response?.user.image, forKey: "image")
                        Indicator.sharedInstance.hideIndicator()
                    if response?.type == "client"{
                        self.presenter?.navigateHome()
                    }
                    else{
                        self.presenter?.provider_Home()
                        
                    }
                }
               
                

            }
             else if error != nil{
                Indicator.sharedInstance.hideIndicator()
                self.presenter?.showErrorAlert(title: Localization.errorLBL , msg: error?.message ?? Localization.data_error )
//                print("message\(error?.message)")
//                print("\(Localization.data_error)")
//                if error?.message == Localization.data_error{
//                    self.presenter?.showErrorAlert(title: Localization.errorLBL , msg: Localization.data_error)
//                }
//                else
//                {
//                    print("")
//                }
//
            }
            else {
                print("bbbbbbb")
            }
            
        })
    }
}
