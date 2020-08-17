
//
//  paymentEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum paymentEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    case accept_offer(bank_name: String, iban_num: Int, offer_num: Int)
    
}

extension paymentEndpoint: IEndpoint {
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
        case .accept_offer:
            
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
        case .accept_offer(_,_, let offer_id):
              return "http://wakil.dev.fudexsb.com/api/offers/\(offer_id)/accept"
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
        case .accept_offer(let bank_name, let iban_number, _):
            
            return ["bank_iban": iban_number , "bank_name": bank_name]
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
        case .accept_offer:
            let userDefaults = UserDefaults.standard
            let token = userDefaults.string(forKey: "token")
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
