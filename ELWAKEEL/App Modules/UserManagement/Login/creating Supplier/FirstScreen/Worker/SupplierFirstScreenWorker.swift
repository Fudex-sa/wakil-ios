//
//  SupplierFirstScreenWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol ISupplierFirstScreenWorker: class {
    
    func registerAPI(name: String,email:String,phone: String, country_code: String, type:String, accepted: Bool,password: String,city_ids: [Int], address: String, latitude: String, longitude: String, complition :  @escaping (_ error: ErrorModel?, _ success: Bool, _ data : SupplierFirstScreenModel.newUser?)-> Void)
    func getcountries(complition :  @escaping (_ error: SupplierFirstScreenModel.AuthError?, _ success: Bool, _ data : [SupplierFirstScreenModel.countries]?)-> Void)
    func getCities(countries: [Int],complition :  @escaping (_ error: SupplierFirstScreenModel.AuthError?, _ success: Bool, _ data : [SupplierFirstScreenModel.Cities]?)-> Void)
}



class SupplierFirstScreenWorker: ISupplierFirstScreenWorker {
    func registerAPI(name: String, email: String, phone: String, country_code: String, type: String, accepted: Bool, password: String, city_ids: [Int], address: String, latitude: String, longitude: String, complition: @escaping (ErrorModel?, Bool, SupplierFirstScreenModel.newUser?) -> Void) {
        
        NetworkService.share.request(endpoint: FirstSupplierEndPointEndpoint.register(name: name, email: email, phone: phone, country_code: country_code, type: type, accepted: accepted, password: password, address: address, city_ids: city_ids, latitude: latitude, longitude: longitude), success: { (responseData) in
            let response = responseData
            print("ddddddddd")
            do{
                print("server")
                let decoder = JSONDecoder()
                let cities = try decoder.decode(SupplierFirstScreenModel.newUser.self, from: response)
                print(cities)
                complition(nil, true,cities)
            }
            catch (let error){
                print("xxxxx\(error.localizedDescription)")
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
    
    
    
    func getCities(countries: [Int], complition: @escaping (SupplierFirstScreenModel.AuthError?, Bool, [SupplierFirstScreenModel.Cities]?) -> Void) {
        NetworkService.share.request(endpoint: FirstSupplierEndPointEndpoint.getCities(countries: countries), success: { (responseData) in
            let response = responseData
            do{
                let decoder = JSONDecoder()
                let cities = try decoder.decode([SupplierFirstScreenModel.Cities].self, from: response)
                complition(nil, true,cities)
            }
            catch _{
                
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(SupplierFirstScreenModel.AuthError.self, from: responseData )
                    print(error)
                    complition(error , false, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
        }) { (error) in
            
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(SupplierFirstScreenModel.AuthError.self, from: error as! Data )
                print(error)
                complition(error , false, nil)
                
            } catch let error {
                print(error)
                complition(nil , false, nil)
            }
            
        }
            
        }
    
    func getcountries(complition: @escaping (SupplierFirstScreenModel.AuthError?, Bool, [SupplierFirstScreenModel.countries]?) -> Void) {
  
        NetworkService.share.request(endpoint: FirstSupplierEndPointEndpoint.countries, success: { (responseData) in
            let response = responseData
            do{
                let decoder = JSONDecoder()
                let countries = try decoder.decode([SupplierFirstScreenModel.countries].self, from: response)
                complition(nil, true,countries)
            }
            catch _{
                
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(SupplierFirstScreenModel.AuthError.self, from: responseData )
                    print(error)
                    complition(error , false, nil)
                } catch let error {
                    print(error)
                    
                }
            }
            
        }) { (error) in
            
            do {
                let decoder = JSONDecoder()
                let error = try decoder.decode(SupplierFirstScreenModel.AuthError.self, from: error as! Data )
                print(error)
                complition(error , false, nil)
                
            } catch let error {
                print(error)
                complition(nil , false, nil)
            }
            
        }
    }
    
   
    
    
   }
