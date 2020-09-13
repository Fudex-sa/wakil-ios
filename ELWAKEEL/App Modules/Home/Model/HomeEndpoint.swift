//
//  HomeEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH

enum HomeEndpoint {
    case advertizing
    case getRequests
    case requestDetails(id: Int)

}

extension HomeEndpoint: IEndpoint {
    var image: UIImage? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .advertizing:
            return .get
        case .getRequests:
            return .get

        case .requestDetails:
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
        case .advertizing:
            return "http://wakil.dev.fudexsb.com/api/ads"
        case .getRequests:
            let id = UserDefaults.standard.integer(forKey: "id")
            return "http://wakil.dev.fudexsb.com/api/clients/\(id)/requests"

        case .requestDetails(let id):
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
        let userDefaults = UserDefaults.standard
        let token = userDefaults.string(forKey: "token")
        let language =  MOLHLanguage.currentAppleLanguage()
    
        switch self {
           case .advertizing:
            return ["Accept": "application/json", "Accept-Language": "\(language)", "Authorization":"bearer \(token!)"]
        case .getRequests:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)"]

        case .requestDetails:
            return ["Accept": "application/json", "Accept-Language": "\(language)", "Authorization":"bearer \(token!)"]
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
