//
//  termsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol ItermsWorker: class {
    func get_terms(complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: termsModel.Terms?)-> Void)
}
class termsWorker: ItermsWorker {
    func get_terms(complition: @escaping (Bool, ErrorModel?, termsModel.Terms?) -> Void) {
        NetworkService.share.request(endpoint: termsEndpoint.terms, success: { (response) in
            print(response.count)
            do{
                let decoder = JSONDecoder()
                let requests = try decoder.decode(termsModel.Terms.self, from: response)
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
                complition(false , (error as! ErrorModel) , nil)
            }
            
        })
    }
    
}

    

