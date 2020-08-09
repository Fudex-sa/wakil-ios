//
//  requestrecordModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct requestrecordModel {	
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
    
    struct recods: Codable {
        let data: [info]
        let links: Links
        let meta: Meta
        
        struct info: Codable {
            var id: Int
            var title: String?
            var description: String?
            var address: String?
            var achievement_proof: String?
            var provider: String?
            var offersCount: Int?
            var status: statu?
            var organization, country, city : organiz?
            var client: clint?
        }
        struct statu: Codable {
            var id: Int?
            var name: String?
            var key: String?
        }
        struct organiz: Codable{
            var id: Int?
            var name: String?
            
        }
        struct clint: Codable {
            var id: Int?
            var name: String?
            var email: String?
            var image: String?
            var phone: String?
            var average_rating: Int?
        }
        struct Links: Codable {
            var first_page_url: String?
            var last_page_url: String?
            var next_page_url: String?
            var prev_page_url: String?
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


