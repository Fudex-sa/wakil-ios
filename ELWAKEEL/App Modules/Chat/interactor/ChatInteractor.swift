//
//  ChatInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IChatInteractor: class {
	var parameters: [String: Any]? { get set }
    func create_message(params: [String: Any], message: Any)
    func get_messages(service_id: Int)
     func make_compliant(service_id: Int, added_by: Int, user_id: Int, content: String)
      func call_manger(service_id: Int)
}

class ChatInteractor: IChatInteractor {
   
    func call_manger(service_id: Int) {
        worker?.call_manger(service_id: service_id, complition: { (success, error, response) in
            if success{
                print("join created interactor")
                self.presenter?.admin_join()
                
            }
            else{
                print("error\(String(describing: error?.message))")
                
            }
            
        })
    }
    
    func make_compliant(service_id: Int, added_by: Int, user_id: Int, content: String) {
        worker?.make_compliant(service_id: service_id, added_by: added_by, user_id: user_id, content: content, complition: { (success, error, respone) in
            if success{
                print("compliant created interactor")
                
            }
            else{
                print("error\(String(describing: error?.message))")
                
            }
        })
    }
    
    func create_message(params: [String : Any], message: Any) {
        worker?.create_message(params: params, message: message,complition: { (success, error, response) in
            
            if success{
                self.presenter?.get_messages()
                print("message created interactor")
                         
            }
            else{
                print("error\(String(describing: error?.localizedDescription))")

            }
            
        })
    }
    
    func get_messages(service_id: Int) {
        worker?.returned_message(service_id: service_id, complition: { (success, error, response) in
            if success {
                if let response = response {
                    self.presenter?.assing_messages(message: response)
                }
                           }
            else{
                print("error\(String(describing: error?.message))")
            }
        })
    }
    
    var presenter: IChatPresenter?
    var worker: IChatWorker?
    var parameters: [String: Any]?

    init(presenter: IChatPresenter, worker: IChatWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
