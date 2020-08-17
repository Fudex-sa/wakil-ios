//
//  Provider_NotificationRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IProvider_NotificationRouter: class {
	// do someting...
}

class Provider_NotificationRouter: IProvider_NotificationRouter {	
	weak var view: Provider_NotificationViewController?
	
	init(view: Provider_NotificationViewController?) {
		self.view = view
	}
}
