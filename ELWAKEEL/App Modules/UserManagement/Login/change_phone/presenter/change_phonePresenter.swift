//
//  change_phonePresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_phonePresenter: class {
	// do someting...
}

class change_phonePresenter: Ichange_phonePresenter {	
	weak var view: Ichange_phoneViewController?
	
	init(view: Ichange_phoneViewController?) {
		self.view = view
	}
}
