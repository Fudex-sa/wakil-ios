//
//  NewPasswordRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol INewPasswordRouter: class {
	// do someting...
}

class NewPasswordRouter: INewPasswordRouter {	
	weak var view: NewPasswordViewController?
	
	init(view: NewPasswordViewController?) {
		self.view = view
	}
}
