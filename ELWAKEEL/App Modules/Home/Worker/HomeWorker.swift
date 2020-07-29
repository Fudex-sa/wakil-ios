//
//  HomeWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IHomeWorker: class {
    func getAdvertising(complition: @escaping (_ success: Bool?,_ error: ErrorModel?, _ data: Data?)-> Void)
	// do someting...
}

class HomeWorker: IHomeWorker {
    func getAdvertising(complition: @escaping (Bool?, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: HomeEndpoint.advertizing, success: { (response) in
            print(response)
            print(response.count)
            complition(nil,nil,nil)
            
            
        }) { (error) in
            complition(nil,nil,nil)
            print(error?.localizedDescription)
            
        }
        
    }
    
	// do someting...
}
