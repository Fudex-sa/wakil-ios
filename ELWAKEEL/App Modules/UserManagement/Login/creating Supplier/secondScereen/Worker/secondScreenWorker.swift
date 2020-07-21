//
//  secondScreenWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit
protocol IsecondScreenWorker: class {
	// do someting...
    func registerAPI(type: String, commercial_number: Int, bank_name: String, bank_iban: Int, commercial_image: UIImage,license_image: UIImage, id: Int, complition :  @escaping (_ error: Error?, _ success: Bool, _ provider: secondScreenModel.newUser?)-> Void )

    
}

class secondScreenWorker: IsecondScreenWorker {
    func registerAPI(type: String, commercial_number: Int, bank_name: String, bank_iban: Int, commercial_image: UIImage, license_image: UIImage, id: Int, complition: @escaping (Error?, Bool, secondScreenModel.newUser?) -> Void) {
        NetworkService.share.uploadImages(type: type, bank_Name: bank_name, Iban_Number: bank_iban, commercial_number: commercial_number, comercial_Image: commercial_image, licence_Image: license_image, id: id){ (error: Error?, success: Bool, data: secondScreenModel.newUser?) in
            
             if success == true{
               complition(nil,true,data)
                
            }
            else{
                print(error?.localizedDescription as Any)
                complition(error,false, nil)
            }
            if error != nil{
                complition(error,false,nil)
            }
          
            
            
        }
            
        
        
        
        
//
//        print("insdie worker")
//        NetworkService.share.uploadToServerWith(endpoint: SecondSupplierEndPointEndpoint.register(type: "provider", commercial_number: commercial_number, bank_name: bank_name, bank_iban: bank_iban, commercial_image: commercial_image, license_image: license_image, id: id), success: { (responseData) in
// print("insdie worker1")
//            let response = responseData
//
//            print("response\(response)")
//            print("success")
//            do{
//               print("inside Do")
//                let decoder = JSONDecoder()
//                print("inside Do1")
//                let cities = try decoder.decode(secondScreenModel.newUser.self, from: response)
//                print("inside Do2")
//                complition(nil, true,cities)
//            }
//            catch _{
//
//                print("inside Catch")
//                do {
//                    let decoder = JSONDecoder()
//                    let error = try decoder.decode(ErrorModel.self, from: responseData )
//                    print("parsing \(error.message)")
//                    complition(error , false, nil)
//                } catch let error {
//                    print(error)
//
//                }
//            }
//
//        }) { (error) in
//
//            do {
//                let decoder = JSONDecoder()
//                let error = try decoder.decode(ErrorModel.self, from: error as! Data )
//                print("error conecc\(error)")
//                complition(error , false, nil)
//
//            } catch let error {
//                print(error)
//                complition(nil , false, nil)
//            }
//
//        }
//
//
    }
    
    
    
	// do someting...
}
