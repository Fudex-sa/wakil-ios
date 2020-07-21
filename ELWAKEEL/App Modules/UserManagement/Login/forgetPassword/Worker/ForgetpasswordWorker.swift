//
//  ForgetpasswordWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IForgetpasswordWorker: class {
	// do someting...
    
    func forgetPasswordAPI(phone: String, Complition: @escaping (_ error: ErrorModel?, _ success: Bool?, _ data: Data?)-> Void)
    
    
}

class ForgetpasswordWorker: IForgetpasswordWorker {
    func forgetPasswordAPI(phone: String, Complition: @escaping (ErrorModel?, Bool?, Data?) -> Void) {
        NetworkService.share.request(endpoint: ForgetPasswordEndPointEndpoint.forgetpassword(password: phone), success: { (responseData) in
            print("City1")
            
            let response = responseData
            print("Response\(response)")
            if responseData.count > 0{
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: responseData )
                    print("ereee\(error)")
                    Complition(error , false, nil)
                } catch let error {
                    print("error1\(error)")
                    
                }
            }
            else{
                 Complition(nil , false, responseData)
            }
           
            
        }) { (error) in
            
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                Complition(error , false, nil)
                
            } catch let error {
                print(error)
                Complition(nil , false, nil)
            }
            
        }
        
    }
    }

