
//
//  create_offerEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum create_offerEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case create_offer(price: Double, required_paper: String, duration: String, service_id: Int)
}

extension create_offerEndpoint: IEndpoint {
    
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
        return .post
    }
    
    var path: String {
        /*
        Do like this:

        switch self {
        case .sample:
            return "https://httpbin.org/get"
        }
        */
        return "http://wakil.dev.fudexsb.com/api/offers/create"
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
        case .create_offer(let price, let required_paper, let duration, let service_id):
            return ["price": price,"required_paper": required_paper, "duration": duration, "service_id": service_id, "provider_id": id]
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
        case .create_offer:
            return ["Accept": "application/json", "Accept-Language":"en", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
        
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
