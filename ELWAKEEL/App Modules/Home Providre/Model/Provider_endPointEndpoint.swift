//
//  Provider_endPointEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum Provider_endPointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case get_new_requests
    case provider_request
    case reject_request(request_id: Int)
}

extension Provider_endPointEndpoint: IEndpoint {
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
        case .get_new_requests:
            return .get
        case .provider_request:
            return .get
        case .reject_request:
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
        let id = UserDefaults.standard.integer(forKey: "id")
        switch self {
        case .get_new_requests:
            return "http://wakil.dev.fudexsb.com/api/providers/\(id)/new-requests"
        case .provider_request:
            return "http://wakil.dev.fudexsb.com/api/providers/\(id)/requests"
        case .reject_request(let request_id):
            return "http://wakil.dev.fudexsb.com/api/requests/\(request_id)/reject"
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
        case .get_new_requests:
            return nil
        case .provider_request:
            return nil
        case .reject_request(let request_id):
            return ["provider_id": id]
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
        case .get_new_requests:
            return ["Accept": "application/json", "Accept-Language":"en", "Authorization":"bearer \(token!)"]
        case .provider_request:
            return ["Accept": "application/json", "Accept-Language":"en", "Authorization":"bearer \(token!)"]
        case .reject_request:
            return ["Accept": "application/json", "Accept-Language":"en", "Authorization":"bearer \(token!)"]
            
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
