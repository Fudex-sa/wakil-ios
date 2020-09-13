//
//  CreatingRequesterEndpointEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum CreatingRequesterEndpointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case register(phone: String)
}

extension CreatingRequesterEndpointEndpoint: IEndpoint {
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
        case .register:
            
        
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
        case .register:
            
        return "http://wakil.dev.fudexsb.com/api/register"
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
        case .register(let phone):
            
            return ["phone":phone, "accepted":"true", "type": "client", "country_code": "+20"]
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
        let language = MOLHLanguage.currentAppleLanguage()

        switch self {
        case .register:
       return ["Accept": "application/json", "Accept-Language":"\(language)", "Content-Type":"application/json"]
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
