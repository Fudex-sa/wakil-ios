//
//  VerificationRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IVerificationRouter: class {
	// do someting...
}

class VerificationRouter: IVerificationRouter {	
	weak var view: VerificationViewController?
	
	init(view: VerificationViewController?) {
		self.view = view
	}
}
