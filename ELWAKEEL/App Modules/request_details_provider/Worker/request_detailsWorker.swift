//
//  request_detailsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol Irequest_detailsWorker: class {
	// do someting...
    
    func request_details(request_id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: request_detailsModel.provider_Request_Details?)-> Void)
    
    func apology_request(request_id: Int, reason: String ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
    
    func done_request(request_id: Int,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
    func rate(rating: Int, user_id: Int, request_id: Int,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
    
    
}

class request_detailsWorker: Irequest_detailsWorker {
    func rate(rating: Int, user_id: Int, request_id: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: request_details_providerEndpoint.rate(rating: rating, user_id: user_id, service_id: request_id), success: { (response) in
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
    func done_request(request_id: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: request_details_providerEndpoint.done_request(request_id: request_id), success: { (response) in
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
    
    func apology_request(request_id: Int, reason: String, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: request_details_providerEndpoint.cancel(request_id: request_id, reason: reason), success: { (response) in
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
    
    func request_details(request_id: Int, complition: @escaping (Bool, ErrorModel?, request_detailsModel.provider_Request_Details?) -> Void) {
        
        NetworkService.share.request(endpoint: request_details_providerEndpoint.request_details(request_id: request_id), success: { (response) in
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(request_detailsModel.provider_Request_Details.self, from: response)
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
