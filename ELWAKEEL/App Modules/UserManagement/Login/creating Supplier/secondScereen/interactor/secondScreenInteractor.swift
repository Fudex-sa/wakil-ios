//
//  secondScreenInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
protocol IsecondScreenInteractor: class {
	var parameters: [String: Any]? { get set }
    func register(type: String, commercial_number: Int, bank_name: String, bank_iban: Int, commercial_image: UIImage,license_image: UIImage, id: Int )
}

class secondScreenInteractor: IsecondScreenInteractor {
    
    
    var presenter: IsecondScreenPresenter?
    var worker: IsecondScreenWorker?
    var parameters: [String: Any]?

    init(presenter: IsecondScreenPresenter, worker: IsecondScreenWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    
    func register(type: String, commercial_number: Int, bank_name: String, bank_iban: Int, commercial_image: UIImage, license_image: UIImage, id: Int) {
        Indicator.sharedInstance.showIndicator()
        
        worker?.registerAPI(type: type, commercial_number: commercial_number, bank_name: bank_name, bank_iban: bank_iban, commercial_image: commercial_image, license_image: license_image, id: id , complition: { (error, success, data) in
            if success{
                Indicator.sharedInstance.hideIndicator()

                self.presenter?.assingNewProvider(provider: data!)
                let userdefults = UserDefaults.standard
                userdefults.set(data?.type, forKey: "type")
                userdefults.set(data?.accessToken, forKey: "token")
                userdefults.set(data?.user.email, forKey: "email")
                userdefults.set(data?.user.name, forKey: "name")
                userdefults.set(data?.user.id, forKey: "id")
                userdefults.set(data?.user.phone, forKey: "phone")
                userdefults.set(data?.user.image, forKey: "image")
                
                self.presenter?.moveToverification(type: data!.type)
            }
            else if error != nil{
                           Indicator.sharedInstance.hideIndicator()

                         self.presenter?.showAlert(title: Localization.errorLBL, msg: Localization.thereiserror)
                           
                       }
            
            else{
                print("no error")
            }
        })
    }
}
