//
//  shareAPPRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IshareAPPRouter: class {
	// do someting...
}

class shareAPPRouter: IshareAPPRouter {	
	weak var view: shareAPPViewController?
	
	init(view: shareAPPViewController?) {
		self.view = view
	}
}
