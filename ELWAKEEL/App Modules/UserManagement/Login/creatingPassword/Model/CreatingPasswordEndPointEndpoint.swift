//
//  CreatingPasswordEndPointEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum CreatingPasswordEndPointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case createNewPassword(password: String,type:String ,id: Int)
}

extension CreatingPasswordEndPointEndpoint: IEndpoint {
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
        case .createNewPassword:
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
        case .createNewPassword(_, _, let id):
            return "http://wakil.dev.fudexsb.com/api/complete-info/\(id)"
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
        case .createNewPassword(let password, let type, _):
            return ["password": password ,"type": type]
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
        switch self {
        case .createNewPassword:
            return ["Accept": "application/json", "Accept-Language":"ar", "Content-Type":"application/json"]
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
