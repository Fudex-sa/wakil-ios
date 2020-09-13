//
//  edit_EndPointEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum edit_EndPointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case edit(id: Int,title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String)
    case get_request(id: Int)

}

extension edit_EndPointEndpoint: IEndpoint {
    var image: UIImage? {
        return nil
    }
    
    var method: HTTPMethod {
        /*
        Do like this:

        switch self {
        case .sample:
            return .get
        }
        */
        
        switch self {
        case .edit:
            return .patch
        case.get_request:
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
        case .edit(let id, _, _, _, _, _, _, _):
        return "http://wakil.dev.fudexsb.com/api/requests/\(id)/edit"
        case .get_request(let id):
            
            return "http://wakil.dev.fudexsb.com/api/requests/\(id)"
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
          
        case .edit(_, let title, let description, let country_id ,let city_id , let organization_id,let address, let achievement_proof):
            let id = UserDefaults.standard.integer(forKey: "id")
            return  ["title": title,"description": description, "country_id": country_id, "city_id": city_id, "type": "public", "organization_id": organization_id, "added_by": id, "address": address, "achievement_proof":achievement_proof]
            
        case .get_request:
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
        let language = MOLHLanguage.currentAppleLanguage()

        switch self {
            
        case .edit:
            
            return ["Accept": "application/json", "Accept-Language": "\(language)", "Authorization": "bearer\(token!)", "Content-Type": "application/json"]
            
        case .get_request:
            return ["Accept": "application/json", "Accept-Language":"en", "Authorization": "bearer \(token!)"]
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
