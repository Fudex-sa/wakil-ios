//
//  Clint_NotificationWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IClint_NotificationWorker: class {
	// do someting...
    func get_notificationsfunc(complition: @escaping ( Bool, _ error: ErrorModel?, _ respones: Clint_NotificationModel.Notification?)-> Void)
}

class Clint_NotificationWorker: IClint_NotificationWorker {
    func get_notificationsfunc(complition: @escaping (Bool, ErrorModel?, Clint_NotificationModel.Notification?) -> Void) {
        NetworkService.share.request(endpoint: Client_endPointEndpoint.notification, success: { (response) in
         print(response)
         do {
            let decode = JSONDecoder()
            let notifications = try decode.decode(Clint_NotificationModel.Notification.self, from: response)
             complition(true, nil,notifications)
             
         }
         catch (let error){
            print("xxxx\(error.localizedDescription)")
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
        print("yyyy\(error?.localizedDescription)")

         
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
