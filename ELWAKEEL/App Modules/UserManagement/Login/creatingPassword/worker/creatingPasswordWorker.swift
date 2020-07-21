//
//  creatingPasswordWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IcreatingPasswordWorker: class {
	// do someting...
    func creatingpasswprdAPI(type: String, password: String, id: Int, complition :  @escaping (_ error:ErrorModel? ,_ success: Bool,_ data: creatingPasswordModel.NewClient?)->Void)
}

class creatingPasswordWorker: IcreatingPasswordWorker {
    func creatingpasswprdAPI(type: String, password: String, id: Int, complition: @escaping (ErrorModel?, Bool, creatingPasswordModel.NewClient?) -> Void) {
        NetworkService.share.request(endpoint: CreatingPasswordEndPointEndpoint.createNewPassword(password: password, type: type, id: id),success: { (responsData) in
            let response = responsData
            print("secind")
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(creatingPasswordModel.NewClient.self, from: response)
                print(user)
                
                complition(nil,true,user)
                
            } catch let error {
                
                do {
                    print(error.localizedDescription)
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: responsData )
                    print(error)
                    print("eeoorrParesing")
                    complition(error , false, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
            
        }, failure: { (error) in
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(error , false , nil)
                
            } catch let error {
                print(error)
                complition(nil , false , nil)
            }
            
        })
    }
    
    
}


