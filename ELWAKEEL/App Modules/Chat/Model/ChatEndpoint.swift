//
//  ChatEndpoint.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import Alamofire
import MOLH
enum ChatEndpoint {
    /*
     Add Endpoint
     case sample
     case sample(parameter:: [String: Any])
    */
    case chat(service_id: Int)
    case create(service_id: Int, type: String, sender_id: Int, reciver_id: Int, message: Any)
    case compliant(content: String, added_by: Int, user_id: Int, service_id: Int)
    case call_manger(service_id: Int)
}

extension ChatEndpoint: IEndpoint {
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
        case .chat:
            return .get
        case .create:
            return .post
        case .compliant:
            return .post
        case .call_manger:
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
        case .chat(let id):
          return "http://wakil.dev.fudexsb.com/api/messages/\(id)"
        case .create:
            return "http://wakil.dev.fudexsb.com/api/messages"
        case .compliant:
            return "http://wakil.dev.fudexsb.com/api/reports/create"
        case .call_manger(let service_id):
            return "http://wakil.dev.fudexsb.com/api/messages/\(service_id)/join"
        }    }
    
    var parameter: Parameters? {
        /*
        Do like this:

        switch self {
        case .sample(let model):
            return model.parameter()
        }
        */
        switch self {
        case .chat:
            return nil
        case .create(service_id: let service_id, type: let type, sender_id: let sender_id, reciver_id: let reciver_id, message: let message):
            switch type {
            case "text":
                 return ["service_id":service_id , "type": type, "sender_id" : sender_id, "receiver_id": reciver_id , "message": message]
            case "img":
                 return ["service_id":service_id , "type": type, "sender_id" : sender_id, "receiver_id": reciver_id , "message": message]
            case "file":
                 return ["service_id":service_id , "type": type, "sender_id" : sender_id, "receiver_id": reciver_id , "message": message]
            case "video":
                 return ["service_id":service_id , "type": type, "sender_id" : sender_id, "receiver_id": reciver_id , "message": message]
            default:
                return nil
            }
           
        case .compliant(content: let content, added_by: let added_by, user_id: let user_id, service_id: let service_id):
           
            return ["content": content, "added_by": added_by , "user_id": user_id, "service_id":service_id]
        case .call_manger:
            return nil
        }    }
    
    var header: HTTPHeaders? {
        /*
        Do like this:

        switch self {
        case .sample:
            return ["key": Any]
        }
        */
        let language = MOLHLanguage.currentAppleLanguage()
        let token = UserDefaults.standard.string(forKey: "token")
     
        switch self {
        case .chat:
          return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
                
        case .create:
             return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
        case .compliant:
            return ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization":"bearer \(token!)", "Content-Type":"application/json"]
        case .call_manger:
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
