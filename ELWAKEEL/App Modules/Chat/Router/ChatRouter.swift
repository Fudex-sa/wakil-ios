//
//  ChatRouter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IChatRouter: class {
	// do someting...
}

class ChatRouter: IChatRouter {	
	weak var view: ChatViewController?
	
	init(view: ChatViewController?) {
		self.view = view
	}
}
