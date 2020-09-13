//
//  CreatingRequesterWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol ICreatingRequesterWorker: class {
	// do someting...
    func signUpAPI(phone: String, complition: @escaping (_ error: ErrorModel?, _ success: Bool, _ data: CreatingRequesterModel.registerCleint?)-> Void)
}

class CreatingRequesterWorker: ICreatingRequesterWorker {
    func signUpAPI(phone: String, complition: @escaping (ErrorModel?, Bool, CreatingRequesterModel.registerCleint?) -> Void) {
        NetworkService.share.request(endpoint: CreatingRequesterEndpointEndpoint.register(phone: phone), success: { (responseData) in
            let response = responseData
            print("user\(response)")
            do{
                let decoder = JSONDecoder()
                let cities = try decoder.decode(CreatingRequesterModel.registerCleint.self, from: response)
                print("userssss\(cities)")
                complition(nil, true,cities)
            }
            catch (let error){
                print(error.localizedDescription)
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(ErrorModel.self, from: responseData )
                    print("parsing \(error)")
                    complition(error , false, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
            
        }) { (error) in
            
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print("error conecc\(error)")
                complition(error , false, nil)
                
            } catch let error {
                print(error)
                complition(nil , false, nil)
            }
            
        }
        }
    }
    
  
    
	// do someting...

