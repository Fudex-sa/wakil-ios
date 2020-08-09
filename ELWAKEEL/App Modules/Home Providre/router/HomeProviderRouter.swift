//
//  HomeProviderRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderRouter: class {
	// do someting...
}

class HomeProviderRouter: IHomeProviderRouter {	
	weak var view: HomeProviderViewController?
	
	init(view: HomeProviderViewController?) {
		self.view = view
	}
}
