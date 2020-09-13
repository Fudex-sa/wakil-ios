//
//  Clint_NotificationModel.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct Clint_NotificationModel {	
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
   
    struct Notification: Codable {
        let data: [Datum]
        let links: Links?
        let meta: Meta?
    }

    struct Datum: Codable {
        let id: String?
        let message: String?
        let service_id: Int?
        let image: String?
        let user_id: Int?

       
    }

    struct Links: Codable {
        let first_page_url, last_page_url, next_page_url, prev_page_url: String?
       
    }

    // MARK: - Meta
    struct Meta: Codable {
        let path: String
        let current_page, from, per_page, to: Int?
        let total: Int?

    }

}
