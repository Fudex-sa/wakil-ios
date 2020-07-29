//
//  FirstSupplierEndPointEndpoint.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire

enum SecondSupplierEndPointEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter: [String: Any])
    */
    
    case register(type: String, commercial_number: Int, bank_name: String, bank_iban: Int, commercial_image: UIImage, license_image: UIImage, id: Int)
}

extension SecondSupplierEndPointEndpoint: IEndpoint {
    
    var image: UIImage?{
        switch self {
        
        case .register(_, _, _, _, let commercial_image,_, _):
            return commercial_image
        }
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
        switch self{
        case .register(_, _, _, _, _,_,_):
       return "http://wakil.dev.fudexsb.com/api/complete-info/9"
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
        case .register(let type, let commercial_number, let bank_name, let bank_iban,let commercial_image , let license_image, _):
        
            return ["type": type,"commercial_number": commercial_number,  "bank_name": bank_name,"bank_iban": bank_iban, "commercial_image": commercial_image,"license_image": license_image]

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
        case .register:
         
            return ["Accept": "application/json", "Accept-Language":"en"]
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
