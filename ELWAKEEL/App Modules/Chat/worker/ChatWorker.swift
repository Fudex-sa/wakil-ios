//
//  ChatWorker.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import  UIKit

protocol IChatWorker: class {
	// do someting...
    func returned_message(service_id: Int ,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: ChatModel.data?)-> Void)
    func create_message(params: [String: Any], message: Any ,complition: @escaping (_ success: Bool,_ error: Error?, _ data: Data?)-> Void)
    func make_compliant(service_id: Int, added_by: Int, user_id: Int, content: String,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: Data?)-> Void)
    func call_manger(service_id: Int,complition: @escaping (_ success: Bool,_ error: ErrorModel?, _ data: [ChatModel.join_admin]?)-> Void)
}

class ChatWorker: IChatWorker {
   
    
    func call_manger(service_id: Int, complition: @escaping (Bool, ErrorModel?, [ChatModel.join_admin]?) -> Void) {
        NetworkService.share.request(endpoint: ChatEndpoint.call_manger(service_id: service_id), success: { (response) in
                      do {
                          let decoder = JSONDecoder()
                        let requests = try decoder.decode([ChatModel.join_admin].self, from: response)
                          print("admin\(requests)")
                          
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
    
    func make_compliant(service_id: Int, added_by: Int, user_id: Int, content: String, complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: ChatEndpoint.compliant(content: content, added_by: added_by, user_id: user_id, service_id: service_id), success: { (response) in
                   if response.count == 0 {
                       print("message created")
                       complition(true,nil,response)
                   }
                   
               } , failure: { (error) in
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
    
    func create_message(params: [String : Any], message: Any, complition: @escaping (Bool, Error?, Data?) -> Void) {
           
     let type = params["type"] as! String
    
        if type == "text" {
        
            let service_id = params["service_id"] as! Int
                let sender_id = params["sender_id"] as! Int
                let reciver_id = params["receiver_id"] as! Int
               let message = message as! String
            NetworkService.share.request(endpoint: ChatEndpoint.create(service_id: service_id, type: type, sender_id: sender_id, reciver_id: reciver_id, message: message), success: { (response) in
                if response.count == 0 {
                    print("message created")
                    complition(true,nil,response)
                }
                
            } , failure: { (error) in
                
                    complition(false , error , nil)
                   
            })
        }
        else{
            
            uploadFiles.shared.upload_file(message: message, params: params) { (error, success, data) in
                 if success {
                    complition(true, nil, data)
                 }
                 else
                 {
                    complition(false, error, nil)
                    
                                }
            }
        }

    }
    
    func returned_message(service_id: Int, complition: @escaping (Bool, ErrorModel?, ChatModel.data?) -> Void) {
        NetworkService.share.request(endpoint: ChatEndpoint.chat(service_id: service_id), success: { (response) in
               do {
                   let decoder = JSONDecoder()
                let requests = try decoder.decode(ChatModel.data.self, from: response)
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
           
	// do someting...
}
}
