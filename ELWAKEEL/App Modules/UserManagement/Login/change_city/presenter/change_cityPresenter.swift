//
//  change_cityPresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_cityPresenter: class {
	// do someting...
}

class change_cityPresenter: Ichange_cityPresenter {	
	weak var view: Ichange_cityViewController?
	
	init(view: Ichange_cityViewController?) {
		self.view = view
	}
}
