//
//  sideMenuProviderRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuProviderRouter: class {
	// do someting...
   
}

class sideMenuProviderRouter: IsideMenuProviderRouter {
 
    
	weak var view: sideMenuProviderViewController?
	
	init(view: sideMenuProviderViewController?) {
		self.view = view
	}
}
