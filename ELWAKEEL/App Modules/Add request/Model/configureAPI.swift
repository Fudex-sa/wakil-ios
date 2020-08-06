//
//  configureAPI.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/4/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
class getCities {
    
    init() {
        
    }
    func getCities(Countries_IDs: [Int], complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getCities(countriesID: Countries_IDs), success: { (response) in
            print("ssssss\(Countries_IDs)")
            print("citiessssss\(response)")
            do {
                let decode = JSONDecoder()
                let organization = try decode.decode([addrequestModel.Organization].self, from: response)
                complition(true, nil,organization)
                
            }
            catch{
                print("error parsing data")
                do {
                    let decode = JSONDecoder()
                    let error = try decode.decode(ErrorModel.self, from: response)
                    complition(false, error, nil)
                }
                catch{
                    print("error parsing error")
                    complition(false, nil, nil)
                }
            }
            
            complition(false,nil,nil)
        }) { (error) in
            
            
            do{
                let decoder = JSONDecoder()
                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
                print(error)
                complition(false , error , nil)
                
            } catch let error {
                print(error)
                complition(false , nil , nil)
            }
            
            
        }
    }
    
}
