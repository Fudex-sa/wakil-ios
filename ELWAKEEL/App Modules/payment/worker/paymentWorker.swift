//
//  paymentWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IpaymentWorker: class {
    
    
    func accept_offer(bank_name: String, iban_num: Int,
                     offer_num: Int, complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
}
class paymentWorker: IpaymentWorker {
    func accept_offer(bank_name: String, iban_num: Int, offer_num: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
         NetworkService.share.request(endpoint: paymentEndpoint.accept_offer(bank_name: bank_name, iban_num: iban_num, offer_num: offer_num), success: { (response) in
            print("LoGS")
            print(response)
            
            complition(true, nil, response)
            
//            do {
//                let decoder = JSONDecoder()
//                let requests = try decoder.decode(provider_logModel.Logs.self, from: response)
//                complition(true,nil,requests)
//
//            } catch _ {
//
//                do {
//                    let decoder = JSONDecoder()
//                    let error = try decoder.decode(ErrorModel.self, from: response )
//                    print(error)
//                    complition(false , error, nil)
//                } catch let error {
//                    print(error)
//
//                }
//            }
            
            
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
    
	// do someting...
}

