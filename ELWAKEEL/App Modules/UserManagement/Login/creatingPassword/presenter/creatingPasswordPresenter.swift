//
//  creatingPasswordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcreatingPasswordPresenter: class {
	// do someting...
}

class creatingPasswordPresenter: IcreatingPasswordPresenter {	
	weak var view: IcreatingPasswordViewController?
	
	init(view: IcreatingPasswordViewController?) {
		self.view = view
	}
}
