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
    func getAdvertising(complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: [HomeModel.Advertising]?)-> Void)
    func getRqeques(complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: HomeModel.requests?)-> Void)
	// do someting...
}

class HomeWorker: IHomeWorker {
    
    func getRqeques(complition: @escaping (Bool, ErrorModel?, HomeModel.requests?) -> Void) {
        NetworkService.share.request(endpoint: HomeEndpoint.getRequests, success: { (response) in
            print(response)
            print("secind")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(HomeModel.requests.self, from: response)
                print(requests)
                print("dataCount\(requests.data.count)")
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
                complition(false , error as! ErrorModel , nil)
            }
            
        })
    }
    
    
    func getAdvertising(complition: @escaping (Bool, ErrorModel?, [HomeModel.Advertising]?) -> Void) {
        NetworkService.share.request(endpoint: HomeEndpoint.advertizing, success: { (response) in
            print(response)
            print(response.count)
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode([HomeModel.Advertising].self, from: response)
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
                complition(false , error as! ErrorModel , nil)
            }
            
        })
    
	// do someting...
}
}
