//
//  addrequestRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaddrequestRouter: class {
	// do someting...
}

class addrequestRouter: IaddrequestRouter {	
	weak var view: addrequestViewController?
	
	init(view: addrequestViewController?) {
		self.view = view
	}
}
