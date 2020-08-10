//
//  shareAPPPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IshareAPPPresenter: class {
	// do someting...
}

class shareAPPPresenter: IshareAPPPresenter {	
	weak var view: IshareAPPViewController?
	
	init(view: IshareAPPViewController?) {
		self.view = view
	}
}
