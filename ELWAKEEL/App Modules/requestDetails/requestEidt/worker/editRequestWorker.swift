//
//  editRequestWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IeditRequestWorker: class {
	// do someting...
    func getRqeques(id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: editRequestModel.RequestDetails?)-> Void)
    func cancelRequest(id: Int, reason: String ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
}

class editRequestWorker: IeditRequestWorker {
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
                complition(false , error as! ErrorModel , nil)
            }
            
        })
        }
    
    
    
    
    func getRqeques(id: Int, complition: @escaping (Bool, ErrorModel?, editRequestModel.RequestDetails?) -> Void) {
        NetworkService.share.request(endpoint: requestDetailsEndpoint.requestDetails(id: id), success: { (response) in
            print(response)
            print("secind")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(editRequestModel.RequestDetails.self, from: response)
                print("hamada\(requests)")
              
                complition(true,nil,requests)
                
            } catch _ {
                
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

