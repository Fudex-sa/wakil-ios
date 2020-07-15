//
//  LOGINRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRouter: class {
	// do someting...
}

class LOGINRouter: ILOGINRouter {	
	weak var view: LOGINViewController?
	
	init(view: LOGINViewController?) {
		self.view = view
	}
}
