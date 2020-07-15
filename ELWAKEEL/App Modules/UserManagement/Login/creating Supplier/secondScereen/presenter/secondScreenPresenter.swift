//
//  secondScreenPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsecondScreenPresenter: class {
	// do someting...
}

class secondScreenPresenter: IsecondScreenPresenter {	
	weak var view: IsecondScreenViewController?
	
	init(view: IsecondScreenViewController?) {
		self.view = view
	}
}
