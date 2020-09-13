//
//  NetworkService.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam/

import Foundation
import Alamofire
import SwiftyJSON

protocol IEndpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
    var image: UIImage? { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}
class NetworkService {
    static let share = NetworkService()
    private var dataRequest: DataRequest?
    private var success: ((_ data: Data?)->Void)?
    private var failure: ((_ error: Error?)->Void)?
    
    @discardableResult
    private func _dataRequest(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {
            return SessionManager.default.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            )
    }
    
    func request<T: IEndpoint>(endpoint: T, success: ((_ data: Data)->Void)? = nil, failure: ((_ error: Error?)->Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            self.dataRequest = self._dataRequest(url: endpoint.path,
                                                 method: endpoint.method,
                                                 parameters: endpoint.parameter,
                                                 encoding: endpoint.encoding,
                                                 headers: endpoint.header)
            self.dataRequest?.responseData(completionHandler: { (response) in
                switch response.result {
                case .success (let value):
                    success?(value)
                    print("mmmmm\(String(describing: response.response?.statusCode))")
                case .failure(let error):
                    print(error)
                }
                
            })
        }
    }
    
    func cancelRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.cancel()
        completion?()
    }
    
    func cancelAllRequest(_ completion: (()->Void)? = nil) {
        dataRequest?.session.getAllTasks(completionHandler: { (tasks) in
            tasks.forEach({ (task) in
                task.cancel()
            })
        })
        completion?()
    }
    
    func success(_ completion: ((_ data: Data?)->Void)?) -> NetworkService {
        success = completion
        return self
    }
    
    func failure(_ completion: ((_ error: Error?)->Void)?) -> NetworkService {
        failure = completion
        return self
    }
}

//MARK:-  Upload Request
extension NetworkService {
    
    func uploadToServerWith<T: IEndpoint>(endpoint: T , image: UIImage, success: ((_ data: Data)->Void)? = nil, failure: ((_ error: Error?)->Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            
            

//            let image = endpoint.image!
           let imgData = image.jpegData(compressionQuality: 0.3)!
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "chat_image",fileName: "chat_image.jpeg", mimeType: "chat_image/jpeg")
                print(endpoint.path)
                for (key, value) in endpoint.parameter ?? ["":""] {
                    print(value)
                    
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)

                    }
            }, usingThreshold:UInt64.init(), to:endpoint.path , method:.post, headers: endpoint.header)
            { (result) in
                switch result {
                case .success(let upload, _ , _):
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseData { (response) in
                        switch response.result {
                        case .success (let value):
                            success?(value)
                              case .failure(let error):
                            print("rrrrr\(error.localizedDescription)")
                        }
                        
                    }
                case .failure(let error):
                    print("error\(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    func uploadImages(type: String, bank_Name: String, Iban_Number: Int, commercial_number: Int, comercial_Image: UIImage, licence_Image: UIImage, id: Int, compition: @escaping((_ error: Error?, _ success: Bool, _ data : secondScreenModel.newUser?)->Void)){
        
        let headers =
            ["Accept": "application/json", "Accept-Language":"en"]
        let commercial_img = comercial_Image.jpegData(compressionQuality: 0.5)
        let licence_Img = licence_Image.jpegData(compressionQuality: 0.5)
        
        Alamofire.upload(multipartFormData: { multipartFormData in            multipartFormData.append(commercial_img!, withName: "commercial_image",fileName: "commercial_image.png" , mimeType: "image/png")
            multipartFormData.append(licence_Img!, withName: "license_image",fileName: "license_image.png" , mimeType: "image/png")
            
            multipartFormData.append(type.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "type")
            multipartFormData.append(bank_Name.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "bank_name")
            
            multipartFormData.append("\(commercial_number)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "commercial_number")
            multipartFormData.append("\(Iban_Number)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "bank_iban")
            
        }, usingThreshold:UInt64.init(),
           to: "http://wakil.dev.fudexsb.com/api/complete-info/\(id)",
           method: .post,
           headers: headers, //pass header dictionary here
            encodingCompletion: { (result) in
                
                switch result {
                    
                case .failure(let error):
                    print(error)
                    compition(error, false, nil)
                    
                    case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):

                    upload.uploadProgress(closure: { (progress: Progress) in
                        print(progress)
                    })
                        .responseJSON(completionHandler: { (response: DataResponse<Any>) in
                            
                            switch response.result
                            {
                            case .failure(let error):
                                print(error)
                                compition(error, false, nil)
                                
                            case .success(let value):
                                do{
                                      let decoder = JSONDecoder()
                                    let New_User = try decoder.decode(secondScreenModel.newUser.self, from: response.data!)
                                    compition(nil,true, New_User)
                                }
                                
                                catch(let error)
                                {
                                    print(error.localizedDescription)
                                    compition(nil,false,nil)
                                }
                            }
                            
                                })
    }
    
    })

    }
    
    
}
