//
//  requestDetailsEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum requestDetailsEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case requestDetails(id: Int)
    case cancelRequset(id: Int, reason: String)
}

extension requestDetailsEndpoint: IEndpoint {
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
        case .requestDetails:
            return .get

       
        case .cancelRequset:
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
        case .requestDetails(let id):
            
        return "http://wakil.dev.fudexsb.com/api/requests/\(id)"
        case .cancelRequset(let id, _):
            return "http://wakil.dev.fudexsb.com/api/requests/\(id)/cancel"
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
        case .cancelRequset(_ , let reason):
            return ["reason": reason]
        case .requestDetails:
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
            
        case .requestDetails:
           return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization": "bearer \(token!)"]
            
        case .cancelRequset:
             return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization": "bearer \(token!)"]
            
        }    }
    
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
