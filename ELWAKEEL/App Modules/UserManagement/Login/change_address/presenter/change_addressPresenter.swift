//
//  change_addressPresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_addressPresenter: class {
	// do someting...
}

class change_addressPresenter: Ichange_addressPresenter {	
	weak var view: Ichange_addressViewController?
	
	init(view: Ichange_addressViewController?) {
		self.view = view
	}
}
