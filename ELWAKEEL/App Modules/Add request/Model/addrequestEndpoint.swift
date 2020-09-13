//
//  addrequestEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum addrequestEndpoint {
    /*
     Add Endpoint
     case sample
     "title": "test",
     ny])
    */
    case addReuset(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String)
    case getOrganization
    case getCountries
    case getCities(countriesID:[Int])
    case add_special_request(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String, provider_id: Int, ads_id: Int)
    
    
}

extension addrequestEndpoint: IEndpoint {
   
    var image: UIImage? {
        return nil
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .addReuset:
           
            return .post
        case .getOrganization:
            return .get
        case .getCountries:
            return .get
        case .getCities:
            return .post
        case .add_special_request:
            return .post
        }
    }
    
    var path: String {
        /*
        Do like this:

        switch self {
        case .sample:
            return "https://httpbin.org/get"
        }
        */
        switch self {
        case .addReuset:
            return "http://wakil.dev.fudexsb.com/api/requests/create"
        case .getOrganization:
            return "http://wakil.dev.fudexsb.com/api/organizations"
        case .getCountries:
            return "http://wakil.dev.fudexsb.com/api/countries"
        case .getCities:
            return "http://wakil.dev.fudexsb.com/api/cities"
        case .add_special_request:
            return "http://wakil.dev.fudexsb.com/api/requests/create"
        }
        
        
    }
    
    var parameter: Parameters? {
        /*
        Do like this:

        switch self {
        case .sample(let model):
            return model.parameter()
        }
        */
        
        let id = UserDefaults.standard.integer(forKey: "id")

        switch self {
        case .addReuset(let title, let description, let country_id ,let city_id , let organization_id,let address, let achievement_proof):
            return  ["title": title,"description": description, "country_id": country_id, "city_id": city_id, "type": "public", "organization_id": organization_id, "added_by": id, "address": address, "achievement_proof":achievement_proof]
        case .getOrganization:
            return nil
        case .getCountries:
            return nil
        case .getCities(let ids):
            return ["country_ids": ids]
        
        case .add_special_request(let title, let description, let country_id, let city_id, let organization_id, let address, let achievement_proof, let provider_id, let ads_id):
            return  ["title": title,"description": description, "country_id": country_id, "city_id": city_id, "type": "special", "organization_id": organization_id, "added_by": id, "address": address, "achievement_proof":achievement_proof , "provider_id": provider_id, "ads_id": ads_id]
        
            
        }
    }
    
    var header: HTTPHeaders? {
        /*
        Do like this:

        switch self {
        case .sample:
            return ["key": Any]
        }
        */
        let userDefaults = UserDefaults.standard
        let token = userDefaults.string(forKey: "token")
        let language = MOLHLanguage.currentAppleLanguage()

        switch self {
        case .addReuset:
            return ["Accept": "application/json", "Accept-Language": "\(language)", "Authorization": "bearer\(token!)", "Content-Type": "application/json"]
        case .getOrganization:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)"]
        case .getCountries:
            return ["Accept": "application/json", "Accept-Language":"\(language)"]
        case .getCities:
            return ["Accept": "application/json", "Accept-Language":"\(language)"]
        case .add_special_request:
            return ["Accept": "application/json", "Accept-Language": "\(language)", "Authorization": "bearer\(token!)", "Content-Type": "application/json"]
        }
        
    }
    
    var encoding: ParameterEncoding {        
        /*
        Do like this:
        
        return URLEncoding.queryString for URL Query
        
        switch self {
        case .sample:
            return JSONEncoding.default
        }
        */
        return JSONEncoding.default
    }
}
