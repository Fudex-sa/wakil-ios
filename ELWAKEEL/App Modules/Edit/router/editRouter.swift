//
//  editRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRouter: class {
	// do someting...
}

class editRouter: IeditRouter {	
	weak var view: editViewController?
	
	init(view: editViewController?) {
		self.view = view
	}
}
