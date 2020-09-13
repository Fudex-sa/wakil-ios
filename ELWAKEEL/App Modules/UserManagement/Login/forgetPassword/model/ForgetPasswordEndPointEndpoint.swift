//
//  ForgetPasswordEndPointEndpoint.swift
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
enum ForgetPasswordEndPointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case forgetpassword(password: String)
    
}

extension ForgetPasswordEndPointEndpoint: IEndpoint {
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
        
        switch self {
        case .forgetpassword:
        return "http://wakil.dev.fudexsb.com/api/password/reset"
            
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
        case .forgetpassword(let phone):
            return ["phone":phone]
            
            
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
        case .forgetpassword:
            let language = MOLHLanguage.currentAppleLanguage()

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
