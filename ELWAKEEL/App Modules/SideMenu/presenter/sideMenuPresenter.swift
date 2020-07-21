//
//  sideMenuPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuPresenter: class {
	// do someting...
}

class sideMenuPresenter: IsideMenuPresenter {	
	weak var view: IsideMenuViewController?
	
	init(view: IsideMenuViewController?) {
		self.view = view
	}
}
