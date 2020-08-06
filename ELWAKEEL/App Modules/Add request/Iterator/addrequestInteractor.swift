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
    func getCountries()
    func getCities(countries_IDs: [Int])
}

class addrequestInteractor: IaddrequestInteractor {
    
    func getCities(countries_IDs: [Int]) {
        worker?.getCities(Countries_IDs: countries_IDs, complition: { (success, error, response) in
            
            print(response)
            if success == true{
                self.presenter?.assignCities(cities: response!)
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
        worker?.getCountries(complition: { (success, error, response) in
            
            if success == true{
                self.presenter?.assignCountries(countries: response!)
                print(response!)
                
            }
            else{
                print(error?.message ?? "")
            }
            
        })
    
    }
    
 
    
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
        
        print("ssssss    \(title)  \(description)   \(country_id)   \(city_id)   \(organization_id)   \(address)  \(achievement_proof) \(UserDefaults.standard.integer(forKey: "id"))")
        worker?.addRequest(title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof, complition: { (success, error, response) in
            if success == true{
                print("successfully allde")
                
                print("userid\(UserDefaults.standard.integer(forKey: "id"))")
                
            }
            else{
                print("error adding request")
                print(error?.message)
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
