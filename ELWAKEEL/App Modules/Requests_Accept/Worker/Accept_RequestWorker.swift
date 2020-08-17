//
//  Accept_RequestWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IAccept_RequestWorker: class {
	// do someting...
    func get_offers(id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Accept_RequestModel.offer?)-> Void)
}

class Accept_RequestWorker: IAccept_RequestWorker {
    func get_offers(id: Int, complition: @escaping (Bool, ErrorModel?, Accept_RequestModel.offer?) -> Void) {
        NetworkService.share.request(endpoint: Accept_RequestEndpoint.offer(id: id), success: { (response) in
            
            print("response\(response)")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(Accept_RequestModel.offer.self, from: response)
                print("hamada\(requests)")
                
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

