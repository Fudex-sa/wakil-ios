//
//  addrequestWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IaddrequestWorker: class {
	// do someting...
    func addRequest(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String, complition: @escaping (Bool, _ error: ErrorModel?, _ respones: Data?)-> Void)
    func add_special_request(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String, provider_id: Int, ads_id: Int, complition: @escaping (Bool, _ error: ErrorModel?, _ respones: Data?)-> Void)
    func getOrganization(complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
    func getCountries(complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
    func getCities(Countries_IDs: [Int],complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
}

class addrequestWorker: IaddrequestWorker {
    func add_special_request(title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String, provider_id: Int, ads_id: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
    
        NetworkService.share.request(endpoint: addrequestEndpoint.add_special_request(title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof, provider_id: provider_id, ads_id: ads_id), success: { (response) in
            print("succsee")
            if response.count == 0{
            complition(true, nil,nil)
            }
            else{
                print("error(")
                
            }
            
        }) { (error) in
            print("errrrrr\(String(describing: error?.localizedDescription))")
            complition(false,error as? ErrorModel,nil)
        }
        
    }
    
    func getCountries(complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getCountries, success: { (response) in
            print(response)
            do {
                let decode = JSONDecoder()
                let organization = try decode.decode([addrequestModel.Organization].self, from: response)
                complition(true, nil,organization)
                
            }
            catch{
                print("error parsing data")
                do {
                    let decode = JSONDecoder()
                    let error = try decode.decode(ErrorModel.self, from: response)
                    complition(false, error, nil)
                }
                catch{
                    print("error parsing error")
                    complition(false, nil, nil)
                }
            }
            
            complition(false,nil,nil)
        }) { (error) in
            
            
            do{
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(false , error , nil)
                
            } catch let error {
                print(error)
                complition(false , nil , nil)
            }
            
            
        }
    }
    
    func getCities(Countries_IDs: [Int], complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getCities(countriesID: Countries_IDs), success: { (response) in
            print("ssssss\(Countries_IDs)")
            print("citiessssss\(response)")
            do {
                let decode = JSONDecoder()
                let organization = try decode.decode([addrequestModel.Organization].self, from: response)
                complition(true, nil,organization)
                
            }
            catch{
                print("error parsing data")
                do {
                    let decode = JSONDecoder()
                    let error = try decode.decode(ErrorModel.self, from: response)
                    complition(false, error, nil)
                }
                catch{
                    print("error parsing error")
                    complition(false, nil, nil)
                }
            }
            
            complition(false,nil,nil)
        }) { (error) in
            
            
            do{
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(false , error , nil)
                
            } catch let error {
                print(error)
                complition(false , nil , nil)
            }
            
            
        }
    }
    
   
    
    func getOrganization(complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getOrganization, success: { (response) in
            print(response)
            do {
               let decode = JSONDecoder()
                let organization = try decode.decode([addrequestModel.Organization].self, from: response)
                complition(true, nil,organization)
                
            }
            catch{
                print("error parsing data")
                do {
                  let decode = JSONDecoder()
                    let error = try decode.decode(ErrorModel.self, from: response)
                    complition(false, error, nil)
                }
                catch{
                    print("error parsing error")
                    complition(false, nil, nil)
                }
            }
            
            complition(false,nil,nil)
        }) { (error) in
           
            
            do{
            let decoder = JSONDecoder()
            let error = try decoder.decode(ErrorModel.self, from: error as! Data )
            print(error)
            complition(false , error , nil)
            
        } catch let error {
            print(error)
            complition(false , nil , nil)
        }
           

        }
    }
    
    
    func addRequest(title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.addReuset(title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof), success: { (response) in
            print("succsee")
            if response.count == 0{
                complition(true, nil,nil)
            }
            else{
                print("error(")
                
            }
        
        }) { (error) in
            print("errrrrr\(String(describing: error?.localizedDescription))")
            complition(false,error as? ErrorModel,nil)
        }
        
    }
    
}
