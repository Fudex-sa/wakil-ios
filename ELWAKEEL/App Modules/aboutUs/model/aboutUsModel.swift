//
//  aboutUsModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct aboutUsModel {	
	struct Request {
		// do someting...

		func parameters() -> [String: Any]? {
			// do someting...
			return nil
		}
	}

	struct Response {
		// do someting...
	}
  
    struct About: Codable {
        let about: AboutClass
        let contacts: [Contact]
    }
    
    // MARK: - AboutClass
    struct AboutClass: Codable {
        let id: Int
        let title, content: String
    }
    
    // MARK: - Contact
    struct Contact: Codable {
        let id: Int
        let key: String
        let value: String
        let name: String
    }

    
}
