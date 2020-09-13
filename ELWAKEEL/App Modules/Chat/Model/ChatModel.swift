//
//  ChatModel.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

struct ChatModel {	
	struct Request {
		// do someting...

		func parameters() -> [String: Any]? {
			// do someting...
			return nil
		}
	}

	struct Response {
        
	}
    
    struct join_admin: Codable {
        let id: Int?
        let user: admin
    }

    struct admin: Codable {
        let id: Int
        let name: String?
        let phone: String
        let email: String?
        let image, averageRating: String?

        enum CodingKeys: String, CodingKey {
            case id, name, phone, email, image
            case averageRating = "average_rating"
        }
    }

    
 struct data: Codable {
        let messages: [Message]
        let members: [Member]
    }

        struct Member: Codable {
            let id: Int
            let user: User
        }

        struct User: Codable {
            let id: Int
            let name: String?
            let phone: String
            let email: String?
            let image, averageRating: String

            enum CodingKeys: String, CodingKey {
                case id, name, phone, email, image
                case averageRating = "average_rating"
            }
        }

        struct Message: Codable {
            let id: Int
            let message, type: String
            let sender: User
            let service: Service
        }

        struct Service: Codable {
            let id: Int
            let requestNumber, title: String

            enum CodingKeys: String, CodingKey {
                case id
                case requestNumber = "request_number"
                case title
            }
        }
}
