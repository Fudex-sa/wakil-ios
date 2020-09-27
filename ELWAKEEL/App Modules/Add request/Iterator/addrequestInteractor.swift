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
    func add_special_request(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String, provider_id: Int, ads_id: Int)
    func getorganzation()
    func getCountries()
    func getCities(countries_IDs: [Int])
}

class addrequestInteractor: IaddrequestInteractor {
    func add_special_request(title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String, provider_id: Int, ads_id: Int) {
    
        print("ssssss    \(title)  \(description)   \(country_id)   \(city_id)   \(organization_id)   \(address)  \(achievement_proof) \(UserDefaults.standard.integer(forKey: "id"))")
        worker?.add_special_request(title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof, provider_id: provider_id, ads_id: ads_id,complition: { (success, error, response) in
            if success == true{
                print("successfully allde")
                
                print("userid\(UserDefaults.standard.integer(forKey: "id"))")
                
            }
            else{
                print("error adding request")
                print(error?.message ?? "error")
            }
            
            
        })
        
    }
    
    
    func getCities(countries_IDs: [Int]) {
        Indicator.sharedInstance.showIndicator()

        worker?.getCities(Countries_IDs: countries_IDs, complition: { (success, error, response) in
            
            if success{
                self.presenter?.assignCities(cities: response!)
                Indicator.sharedInstance.hideIndicator()

                self.presenter?.goHome()
                print(response!)
               print("success Getting data")
                
            }
            else{
                print("error Getting data")
                print(error?.message ?? "")
            }
            
        })
           }
    
    func getCountries() {
        Indicator.sharedInstance.showIndicator()
        worker?.getCountries(complition: { (success, error, response) in
            
            if success == true{
                self.presenter?.assignCountries(countries: response!)
                Indicator.sharedInstance.hideIndicator()

                print(response!)
                
            }
            else{
                Indicator.sharedInstance.hideIndicator()

                print(error?.message ?? "")
            }
            
        })
    
    }
    
 
    
    func getorganzation() {
        worker?.getOrganization(complition: { (success, error, response) in
            if success{
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
            if success == true{
             
                self.presenter?.showAlert()
                print()
            }
            else{
                print("error adding request")
                print(error?.message ?? "error")
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
