//
//  sideMenuWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IsideMenuWorker: class {
	// do someting...
    
    func getRqeques(complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: sideMenuModel.requests?)-> Void)
    // do someting...
}

class sideMenuWorker: IsideMenuWorker {
    func getRqeques(complition: @escaping (Bool, ErrorModel?, sideMenuModel.requests?) -> Void) {
        NetworkService.share.request(endpoint: HomeEndpoint.getRequests, success: { (response) in
            print(response)
            print("secind")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(sideMenuModel.requests.self, from: response)
                print(requests)
                print("dataCount\(requests.data.count)")
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
