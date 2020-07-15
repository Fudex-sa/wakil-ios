//
//  CreatingRequesterRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterRouter: class {
	// do someting...
}

class CreatingRequesterRouter: ICreatingRequesterRouter {	
	weak var view: CreatingRequesterViewController?
	
	init(view: CreatingRequesterViewController?) {
		self.view = view
	}
}
