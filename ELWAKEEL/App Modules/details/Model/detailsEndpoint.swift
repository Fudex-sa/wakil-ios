//
//  detailsEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum detailsEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
     case request_details(request_id: Int)
}

extension detailsEndpoint: IEndpoint {
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
        return .get
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
        return nil
    }
    
    var header: HTTPHeaders? {
        /*
        Do like this:

        switch self {
        case .sample:
            return ["key": Any]
        }
        */
        switch self {
        case .request_details:
            let userDefaults = UserDefaults.standard
            let token = userDefaults.string(forKey: "token")
            let language = MOLHLanguage.currentAppleLanguage()

            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
            
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
