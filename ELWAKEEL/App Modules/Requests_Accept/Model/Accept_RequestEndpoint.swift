//
//  Accept_RequestEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH

enum Accept_RequestEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case offer(id: Int)

}

extension Accept_RequestEndpoint: IEndpoint {
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
        case .offer:
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
        case .offer(let id):
                return "http://wakil.dev.fudexsb.com/api/requests/\(id)/offers"
            
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
        case .offer:
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
        case .offer:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
            
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
