//
//  sideMenuRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuRouter: class {
	// do someting...
   
}

class sideMenuRouter: IsideMenuRouter {
   
    
	weak var view: sideMenuViewController?
	
	init(view: sideMenuViewController?) {
		self.view = view
	}
}
