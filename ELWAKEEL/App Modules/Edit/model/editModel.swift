//
//  editModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct editModel {	
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
    
    struct edit: Codable {
        let id: Int
        let title, description: String?
        let status: Status?
        let organization, city, country: City
        let address, achievement_proof: String?
        let client: Client?
        let progress_time: String?
        let offer: Offer?
        let done_time: String?
        
        
    }
    
    // MARK: - City
    struct City: Codable {
        let id: Int?
        let name: String?
    }
    
    // MARK: - Client
    struct Client: Codable {
        let id: Int
        let name: String?
        let phone: String
        let email: String?
        let image: String?
        let average_rating: String?
        
        
    }
    
    // MARK: - Offer
    struct Offer: Codable {
        let id, price_after_tax: Int
        let required_paper, duration: String
        let provider: Client
        
        
    }
    
    // MARK: - Status
    struct Status: Codable {
        let id: Int?
        let name, key: String?
    }
    
    
}
