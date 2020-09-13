//
//  edit_profilePresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iedit_profilePresenter: class {
	// do someting...
}

class edit_profilePresenter: Iedit_profilePresenter {	
	weak var view: Iedit_profileViewController?
	
	init(view: Iedit_profileViewController?) {
		self.view = view
	}
}
