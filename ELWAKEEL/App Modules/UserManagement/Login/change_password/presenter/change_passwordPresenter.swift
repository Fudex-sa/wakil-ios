//
//  change_passwordPresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_passwordPresenter: class {
	// do someting...
}

class change_passwordPresenter: Ichange_passwordPresenter {	
	weak var view: Ichange_passwordViewController?
	
	init(view: Ichange_passwordViewController?) {
		self.view = view
	}
}
