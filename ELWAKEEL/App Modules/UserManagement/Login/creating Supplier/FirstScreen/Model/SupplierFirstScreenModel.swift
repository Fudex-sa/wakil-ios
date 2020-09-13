//
//  SupplierFirstScreenModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct SupplierFirstScreenModel {	
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
    struct countries: Codable{
        let id: Int?
        let name: String?
    }
    struct AuthError: Codable {
        let status: Bool?
        let errors: Error?
    }
    struct Error: Codable {
        let key, value: String
    }
    
    struct Cities: Codable{
        let id: Int?
        let name: String?
    }
    struct newUser: Codable {
        let id: Int?
        let name, phone, email: String?
        let averageRating: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, phone, email
            case averageRating = "average_rating"
        }
    }

}
