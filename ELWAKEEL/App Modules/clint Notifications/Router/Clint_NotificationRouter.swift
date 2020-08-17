//
//  Clint_NotificationRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IClint_NotificationRouter: class {
	// do someting...
}

class Clint_NotificationRouter: IClint_NotificationRouter {	
	weak var view: Clint_NotificationViewController?
	
	init(view: Clint_NotificationViewController?) {
		self.view = view
	}
}
