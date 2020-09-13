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
import MOLH
enum FirstSupplierEndPointEndpoint {
    /*
     Add Endpoint
     case sample
     
     case sample(parameter: [String: Any])
    */
    case register(name: String,email:String, phone: String, country_code: String, type: String, accepted:Bool, password: String, address: String, city_ids: [Int], latitude: String, longitude: String)
    case countries
    case getCities(countries: [Int])
    
}

extension FirstSupplierEndPointEndpoint: IEndpoint {
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
        case.countries:
        return .get
        case .getCities:
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
        case .countries:
            return "http://wakil.dev.fudexsb.com/api/countries"
        case .getCities:
            return "http://wakil.dev.fudexsb.com/api/cities"
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
        case .register(let name, let email, let phone, let country_code, _, let accepted, let password, let address, let city_ids, let latitude, let longitude):
            
            return ["name":name,"email":email,"phone":phone,"country_code":country_code,"type":"provider","accepted": accepted,"password":password,"city_ids": city_ids,"address":address,"latitude":latitude,"longitude":longitude]
        case .countries:
            return nil
        case .getCities(let countries):
            return ["country_ids": countries]
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
        case .countries:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Content-Type":"application/json"]
        case .getCities(_):
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
