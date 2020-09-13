//
//  request_details_providerEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH

enum request_details_providerEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case request_details(request_id: Int)
    case cancel(request_id: Int, reason: String)
    case done_request(request_id: Int)
    case rate(rating: Int, user_id: Int, service_id: Int)
}

extension request_details_providerEndpoint: IEndpoint {
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
        case .request_details:
            
            return .get
        case .cancel:
           return .post
        case .done_request:
            return .get
       
        case .rate:
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
        case .request_details(let request_id):
            
            return "http://wakil.dev.fudexsb.com/api/requests/\(request_id)"
            
        case .cancel(let request_id, _):
            return "http://wakil.dev.fudexsb.com/api/requests/\(request_id)/apology"
            
        case .done_request(let request_id):
            return "http://wakil.dev.fudexsb.com/api/requests/\(request_id)/done"
        case .rate:
            return "http://wakil.dev.fudexsb.com/api/ratings/create"
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
        case .request_details:
            
            return nil
        case .cancel(_, let reason):
            return ["reason": reason]
        case .done_request:
            return nil
        case .rate(let rating, let user_id, let service_id):
            return ["rate": rating, "rated_by": id, "user_id": user_id, "service_id": service_id]
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
        case .request_details:
            
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
            
        case .cancel:
            
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
            
        case .done_request:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
        case .rate:
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
