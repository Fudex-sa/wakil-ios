//
//  HomeRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeRouter: class {
	// do someting...
}

class HomeRouter: IHomeRouter {	
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
}
