//
//  detailsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IdetailsWorker: class {
    
    
    func request_details(request_id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: detailsModel.Request_Details?)-> Void)

	// do someting...
}

class detailsWorker: IdetailsWorker {
    func request_details(request_id: Int, complition: @escaping (Bool, ErrorModel?, detailsModel.Request_Details?) -> Void) {
        NetworkService.share.request(endpoint: detailsEndpoint.request_details(request_id: request_id), success: { (response) in
            
            print("details\(response)")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(detailsModel.Request_Details.self, from: response)
                print("fffffff\(requests)")
                
                complition(true,nil,requests)
                
            } catch (let error) {
                
                print("erorrr\(error.localizedDescription)")
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: response )
                    print(error)
                    print("pppppp")
                    complition(false , error, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
            
        }, failure: { (error) in
            print("faikur")
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
