//
//  CreatingRequesterModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct CreatingRequesterModel {	
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
    
    struct registerCleint: Codable {
            let id: Int?
            let name: String?
            let phone: String?
            let email: String?
            let image: String?
            let average_rating: String?
            
        }  
    }

