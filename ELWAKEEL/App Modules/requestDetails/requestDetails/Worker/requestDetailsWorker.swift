//
//  requestDetailsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IrequestDetailsWorker: class {
	// do someting...
    func cancelRequest(id: Int, reason: String ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
    
    
    func request_details(request_id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: requestDetailsModel.RequestDetails?)-> Void)
}

class requestDetailsWorker: IrequestDetailsWorker {
    func request_details(request_id: Int, complition: @escaping (Bool, ErrorModel?, requestDetailsModel.RequestDetails?) -> Void) {
        NetworkService.share.request(endpoint: requester_detailsEndpoint.request_details(request_id: request_id), success: { (response) in
            
            print("details\(response)")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(requestDetailsModel.RequestDetails.self, from: response)
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

    func cancelRequest(id: Int, reason: String, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        
        NetworkService.share.request(endpoint: requestDetailsEndpoint.cancelRequset(id: id, reason: reason), success: { (response) in
            if  response.count == 0{
                print("cancled")
                complition(true, nil, response)
            }
            
        }, failure: { (error) in
            print("SSSSSSSERRRRor")
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
