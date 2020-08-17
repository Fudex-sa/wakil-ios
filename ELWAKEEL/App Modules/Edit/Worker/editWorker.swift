//
//  editWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IeditWorker: class {
    
    func edit_Request(idL: Int, title: String, description: String, country_id: Int,city_id: Int, organization_id: Int, address: String, achievement_proof: String, complition: @escaping (Bool, _ error: ErrorModel?, _ respones: editModel.edit?)-> Void)
    func getOrganization(complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
    func getCountries(complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
    func getCities(Countries_IDs: [Int],complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: [addrequestModel.Organization]?)-> Void)
     func getRqeques(id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: editModel.edit?)-> Void)

	// do someting...
}

class editWorker: IeditWorker {
   
    

    func getRqeques(id: Int, complition: @escaping (Bool, ErrorModel?, editModel.edit?) -> Void) {
        NetworkService.share.request(endpoint: edit_EndPointEndpoint.get_request(id: id), success: { (response) in
            print(response)
            print("secind")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(editModel.edit.self, from: response)
                print("fffff\(requests)")
                
                complition(true,nil,requests)
                
            } catch (let error) {
                
                do {
                    print("error parsing")
print(error.localizedDescription)
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
    func getCountries(complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getCountries, success: { (response) in
            print(response)
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
    
    
    
    func getOrganization(complition: @escaping (Bool, ErrorModel?, [addrequestModel.Organization]?) -> Void) {
        NetworkService.share.request(endpoint: addrequestEndpoint.getOrganization, success: { (response) in
            print(response)
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
    func edit_Request(idL: Int, title: String, description: String, country_id: Int, city_id: Int, organization_id: Int, address: String, achievement_proof: String, complition: @escaping (Bool, ErrorModel?, editModel.edit?) -> Void) {
        NetworkService.share.request(endpoint: edit_EndPointEndpoint.edit(id: idL, title: title, description: description, country_id: country_id, city_id: city_id, organization_id: organization_id, address: address, achievement_proof: achievement_proof), success: { (response) in
            
            print("response\(response)")
            
            do {
                let decoder = JSONDecoder()
                let requests = try decoder.decode(editModel.edit.self, from: response)
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
    
	// do someting...
}
