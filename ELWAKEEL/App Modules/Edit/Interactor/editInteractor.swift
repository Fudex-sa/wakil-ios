//
//  editInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditInteractor: class {
	var parameters: [String: Any]? { get set }
    func edit_request(id: Int,title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String)
    func getorganzation()
    func getCountries()
    func getCities(countries_IDs: [Int])
    func getRequest_Datails(id: Int)

}

class editInteractor: IeditInteractor {
    
    var presenter: IeditPresenter?
    var worker: IeditWorker?
    var parameters: [String: Any]?

    init(presenter: IeditPresenter, worker: IeditWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    func getRequest_Datails(id: Int) {
        worker?.getRqeques(id: id, complition: { (success, error, respnse) in
            if success{
                if let respnse = respnse{
                    self.presenter?.assign_request(request: respnse)
                }
                else{
                    
                }
            }
            else{
                print("error \(String(describing: error?.message))")
            }
        })
    }
    
    func getCities(countries_IDs: [Int]) {
        worker?.getCities(Countries_IDs: countries_IDs, complition: { (success, error, response) in
            
            if success{
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
            if success{
                self.presenter?.assignOrganization(organizations: response!)
                print(response!)
                
            }
            else{
                print(error?.message ?? "")
            }
            
        })
    }
    func edit_request(id: Int, title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String) {
        
        print("ssssss    \(title)  \(description)   \(country_id)   \(city_id)   \(organization_id)   \(address)  \(achievement_proof) \(UserDefaults.standard.integer(forKey: "id"))")
        worker?.edit_Request(idL: id, title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof, complition: { (success, error, response) in
            if success{
                print("successfully allde")
                if let response = response{
                self.presenter?.goHome()
                print("userid\(UserDefaults.standard.integer(forKey: "id"))")
                
                }
                else{
                    
                }
            }
            else{
                print("error adding request")
                print(error?.message ?? "error")
            }
            
            
        })
    }
    
    
    
}
