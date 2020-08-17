//
//  contactUsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IcontactUsWorker: class {
	// do someting...
    func contact(name: String, email: String, subject:String, content: String, phone: String, complition: @escaping(_ succecc: Bool, _ error: ErrorModel? , _ response: Data?)-> Void)
    
}

class contactUsWorker: IcontactUsWorker {
    func contact(name: String, email: String, subject: String, content: String, phone: String, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: contactUsEndpoint.contact(name: name, email: email, phone: phone, subject: subject, content: content), success: { (response) in
            print(response.count)
            
            if  response.count == 0{
                complition(true, nil, response)
            }
            else {
                complition(false, nil , nil)
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
