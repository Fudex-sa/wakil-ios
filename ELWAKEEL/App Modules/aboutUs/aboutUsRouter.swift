//
//  aboutUsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaboutUsRouter: class {
	// do someting...
}

class aboutUsRouter: IaboutUsRouter {	
	weak var view: aboutUsViewController?
	
	init(view: aboutUsViewController?) {
		self.view = view
	}
}
