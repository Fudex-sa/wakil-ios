//
//  LOGINRequesterWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import SwiftyJSON
protocol ILOGINRequesterWorker: class {
    
    func loginFromApi(phone: String ,password: String ,complition :  @escaping (_ error:ErrorModel? ,_ success: Bool,_ data: LOGINRequesterModel.loginSuccess?)->Void)
	// do someting...
}

class LOGINRequesterWorker: ILOGINRequesterWorker {
    func loginFromApi(phone: String, password: String, complition: @escaping (ErrorModel?, Bool, LOGINRequesterModel.loginSuccess?) -> Void) {
        NetworkService.share.request(endpoint: loginEndpoint.login(phone: phone, password: password ),success: { (responsData) in
            print("response",(responsData))
            let response = responsData
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(LOGINRequesterModel.loginSuccess.self, from: response)
                print(user)
                complition(nil,true,user)
                
            } catch (let error){
                print("error",(error.localizedDescription))
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: responsData )
                    print(error.message)
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
