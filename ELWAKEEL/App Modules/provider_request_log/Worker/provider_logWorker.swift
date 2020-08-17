//
//  provider_logWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol Iprovider_logWorker: class {
    
    
    func get_records(complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: provider_logModel.Logs?)-> Void)
}

class provider_logWorker: Iprovider_logWorker {
    func get_records(complition: @escaping (Bool, ErrorModel?, provider_logModel.Logs?) -> Void) {
        NetworkService.share.request(endpoint: provider_logEndpoint.log, success: { (response) in
            print("LoGS")
            print(response)
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(provider_logModel.Logs.self, from: response)
                complition(true,nil,requests)
                
            } catch _ {
                
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: response )
                    print(error)
                    complition(false , error, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
            
        }, failure: { (error) in
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(false , error , nil)
                
            } catch let error {
                print(error)
                complition(false , (error as! ErrorModel) , nil)
            }
            
        })
    }
	// do someting...
}
