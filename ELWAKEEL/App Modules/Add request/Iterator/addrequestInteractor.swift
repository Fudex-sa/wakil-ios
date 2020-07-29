//
//  addrequestInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaddrequestInteractor: class {
	var parameters: [String: Any]? { get set }
    func addreuest(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String)
    func getorganzation()
}

class addrequestInteractor: IaddrequestInteractor {
    func getorganzation() {
        worker?.getOrganization(complition: { (success, error, response) in
            print(response)
            if success == true{
                self.presenter?.assignOrganization(organizations: response!)
                print(response!)
                
            }
            else{
                print(error?.message ?? "")
            }
            
        })
    }
    
    func addreuest(title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String) {
        worker?.addRequest(title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof, complition: { (success, error, response) in
            print(response)
            if success == true{
               print("interactor\(response)")
            }
            else{
                print("interacor\(error?.message)")
            }
            
            
        })
    }
    
    var presenter: IaddrequestPresenter?
    var worker: IaddrequestWorker?
    var parameters: [String: Any]?

    init(presenter: IaddrequestPresenter, worker: IaddrequestWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
