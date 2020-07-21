//
//  NewPasswordWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol INewPasswordWorker: class {
	// do someting...
    func updatePasswordAPI(password: String, Phone: String, complition :  @escaping (_ error:ErrorModel? ,_ success: Bool,_ data: Data?)->Void)
}

class NewPasswordWorker: INewPasswordWorker {
    func updatePasswordAPI(password: String, Phone: String, complition: @escaping (ErrorModel?, Bool, Data?) -> Void) {
        NetworkService.share.request(endpoint: NewPasswordEndPointEndpoint.newPassword(phone: Phone, password: password), success: { (responseData) in
            
            let response = responseData
            print("Response\(response)")
            if responseData.count != 0{
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: responseData )
                    print("ereee\(error)")
                    complition(error , false, nil)
                } catch let error {
                    print("error1\(error)")
                    
                }
            }
            else{
                print("hhhhh")
                complition(nil , false, responseData)
                print("hhhhhh")
            }
            
            
        }) { (error) in
            
            do {
                print("ffffff")
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(error , false, nil)
                
            } catch let error {
                print(error)
                complition(nil , false, nil)
            }
            
        }
        
    }
    }
