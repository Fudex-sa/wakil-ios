//
//  uploadfiles.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/3/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MOLH
class uploadFiles{
    public static let shared = uploadFiles()
    func upload_file(message: Any?,params: [String:Any], compition: @escaping((_ error: Error?, _ success: Bool, _ data : Data?)->Void)){
    let type = params["type"] as! String
        let token = UserDefaults.standard.string(forKey: "token")
        let language = MOLHLanguage.currentAppleLanguage()
        let headers =
        ["Accept": "application/json", "Accept-Language":"\(language)", "Authorization": "bearer\(token!)", "Content-Type":"application/x-www-form-urlencoded"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            if type == "img"{
                let image = message as! UIImage
                let imgData = image.jpegData(compressionQuality: 0.2)!
                multipartFormData.append(imgData, withName: "message",fileName: "file.jpg", mimeType: "image/jpg")
            }
            else if type == "video" {
                
                let url = message as! URL
                let videoData = try! Data(contentsOf: url.asURL())
                multipartFormData.append(videoData, withName: "message", fileName: "video.mp4", mimeType:"video/mp4")
            }
            else if type == "file"
            {
                let url = message as! URL
                let pdfData = try! Data(contentsOf: url.asURL())
                multipartFormData.append(pdfData, withName: "message", fileName: "pdf", mimeType:"application/pdf")
            }
            
            
               
                for (key, value) in params {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
            },
        to:"http://wakil.dev.fudexsb.com/api/messages",
        method: .post,
        headers: headers
        
            )
        { (result) in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseJSON { response in
                    print(response.result.value as Any)
                    if response.response?.statusCode == 204{
                        compition(nil, true, response.data)

                    }
                    else {
                        print("error parsing")
                        compition(nil, false, nil)

                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
                compition(error, false, nil)
            }
        }
}
    
}
