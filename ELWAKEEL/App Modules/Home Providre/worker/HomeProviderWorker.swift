//
//  HomeProviderWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IHomeProviderWorker: class {
	// do someting...
    func naer_requests(complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: HomeProviderModel.new_requests?)-> Void)
    func provider_request(complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: HomeProviderModel.provider_request?)-> Void)
    func reject_request(request_id: Int, complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: Data?)-> Void)
    
}

class HomeProviderWorker: IHomeProviderWorker {
    func reject_request(request_id: Int, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: Provider_endPointEndpoint.reject_request(request_id: request_id), success: { (response) in
            
            print("response")
            print(response)
            if response.count == 0{
                complition(true,nil,response)
            }
            else{
                complition(true,nil,nil)
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
    
    
    
    func provider_request(complition: @escaping (Bool, ErrorModel?, HomeProviderModel.provider_request?) -> Void) {
        NetworkService.share.request(endpoint: Provider_endPointEndpoint.provider_request, success: { (response) in
            
            print(response)
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(HomeProviderModel.provider_request.self, from: response)
                print(requests)
                print("dataCount\(requests.data.count)")
                complition(true,nil,requests)
                
            } catch (let error){
                print("error1\(error.localizedDescription)")
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
    
    
    func naer_requests(complition: @escaping (Bool, ErrorModel?, HomeProviderModel.new_requests?) -> Void) {
        NetworkService.share.request(endpoint: Provider_endPointEndpoint.get_new_requests, success: { (response) in
           print("get_near_requests")
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(HomeProviderModel.new_requests.self, from: response)
                print("hamada\(requests.data.count)")
                print(requests.data)
                  complition(true,nil,requests)
                
            } catch (let error) {
                print("error\(error.localizedDescription)")
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

