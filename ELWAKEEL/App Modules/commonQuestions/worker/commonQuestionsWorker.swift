//
//  commonQuestionsWorker.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation

protocol IcommonQuestionsWorker: class {
    func getquestion(complition: @escaping(_ success: Bool, _ error: ErrorModel?, _ response: Data?)-> Void)
}
	// do someting...


class commonQuestionsWorker: IcommonQuestionsWorker {
    func getquestion(complition: @escaping (Bool, ErrorModel?, Data?) -> Void) {
        NetworkService.share.request(endpoint: commonQuestionsEndpoint.getQuestion, success: { (response) in
            print(response)
            complition(true, nil, response)
            
        }) { (error) in
            complition(false, (error as! ErrorModel), nil)
            
        }
    }
    
	// do someting...
}
