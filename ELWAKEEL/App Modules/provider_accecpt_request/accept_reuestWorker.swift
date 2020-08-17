//
//  accept_reuestWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol Iaccept_reuestWorker: class {
	// do someting...
    
    func create_offer(price: Double, required_paper: String, duration: String, service_id: Int, complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: Data?)-> Void)
    
}

class accept_reuestWorker: Iaccept_reuestWorker {
    func create_offer(price: Double, required_paper: String, duration: String, service_id: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: create_offerEndpoint.create_offer(price: price, required_paper: required_paper, duration: duration, service_id: service_id), success: { (response) in
            
            print("response")
            print(response)
            if response.count == 0{
                complition(true,nil,response)
            }
            else{
                complition(true,nil,nil)
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
    
}
