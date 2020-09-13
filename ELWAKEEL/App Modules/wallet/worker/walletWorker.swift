//
//  walletWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IwalletWorker: class {
	// do someting...
func get_wallet(complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: walletModel.wallet?)-> Void)
}

class walletWorker: IwalletWorker {
    func get_wallet(complition: @escaping (Bool, ErrorModel?, walletModel.wallet?) -> Void) {
     NetworkService.share.request(endpoint: walletEndpoint.wallet, success: { (response) in
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(walletModel.wallet.self, from: response)
                complition(true,nil,requests)
                
            } catch (let error) {
              
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
