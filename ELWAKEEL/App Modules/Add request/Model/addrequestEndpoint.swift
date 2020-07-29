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

enum addrequestEndpoint {
    /*
     Add Endpoint
     case sample
     "title": "test",
     ny])
    */
    case addReuset(title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String)
    case getOrganization
    
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
        switch self {
        case .addReuset(let title, let description, let country_id ,let city_id , let organization_id,let address, let achievement_proof):
          let id = UserDefaults.standard.integer(forKey: "id")
            return  ["title": title,"description": description, "country_id": country_id, "city_id": city_id, "type": "public", "organization_id": organization_id, "added_by": id, "address": address, "achievement_proof":achievement_proof]
        case .getOrganization:
            return nil
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
        switch self {
        case .addReuset:
        
         
            return ["Accept": "application/json", "Accept-Language":"ar", "Authorization":"bearer \(token!)"]
        case .getOrganization:
            return ["Accept": "application/json", "Accept-Language":"ar", "Authorization":"bearer \(token!)"]
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
