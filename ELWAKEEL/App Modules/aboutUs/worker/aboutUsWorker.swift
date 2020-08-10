//
//  aboutUsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IaboutUsWorker: class {
	// do someting...
    
        func getContact_info(complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: aboutUsModel.About?)-> Void)
}

class aboutUsWorker: IaboutUsWorker {
    func getContact_info(complition: @escaping (Bool, ErrorModel?, aboutUsModel.About?) -> Void) {
        NetworkService.share.request(endpoint: aboutUsEndpoint.contact_info, success: { (response) in
            print(response.count)
            do{
            let decoder = JSONDecoder()
            let requests = try decoder.decode(aboutUsModel.About.self, from: response)
            print(requests)
            print("dataCount\(requests)")
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
    complition(false , error as! ErrorModel , nil)
    }
    
    })
}

    }
    

