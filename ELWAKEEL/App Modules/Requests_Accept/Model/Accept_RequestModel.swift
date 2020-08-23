//
//  Accept_RequestModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct Accept_RequestModel {	
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
    
    
    
    struct offer: Codable {
        var data: [offer_info]
        var links: Links
        var meta: Meta
        
        struct offer_info: Codable {
            var id: Int?
            var price_after_tax: String?
            var required_paper: String?
            var duration: String?
            var provider: clint?
            
        }
        struct clint: Codable {
            var id: Int?
            var name: String?
            var phone: String?
            var email: String?
            var image: String?
            var average_rating: String?
        }
        struct Links: Codable {
            var first_page_url: String?
            var last_page_url: String?
            var next_page_url: String?
            var prev_page_url: String?
//        }
        }
        struct Meta: Codable {
            var path: String?
            var current_page: Int?
            var from: Int?
            var per_page: Int?
            var to: Int?
            var total: Int?
        }
    }
    
    
}
