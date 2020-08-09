//
//  sideMenuProviderPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuProviderPresenter: class {
	// do someting...
}

class sideMenuProviderPresenter: IsideMenuProviderPresenter {	
	weak var view: IsideMenuProviderViewController?
	
	init(view: IsideMenuProviderViewController?) {
		self.view = view
	}
}
