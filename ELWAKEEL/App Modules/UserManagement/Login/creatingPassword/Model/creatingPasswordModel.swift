//
//  creatingPasswordModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct creatingPasswordModel {	
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
    
    struct NewClient: Codable {
        let user: User
        let type, accessToken, tokenType: String
        let expiresIn: Int
        
        enum CodingKeys: String, CodingKey {
            case user, type
            case accessToken = "access_token"
            case tokenType = "token_type"
            case expiresIn = "expires_in"
        }
    }
    
    // MARK: - User
    struct User: Codable {
        let id: Int?
        let name, phone, email: String?
        let averageRating: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, phone, email
            case averageRating = "average_rating"
        }
    }
}
