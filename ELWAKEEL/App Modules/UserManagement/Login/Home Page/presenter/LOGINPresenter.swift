//
//  LOGINPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINPresenter: class {
	// do someting...
}

class LOGINPresenter: ILOGINPresenter {	
	weak var view: ILOGINViewController?
	
	init(view: ILOGINViewController?) {
		self.view = view
	}
}
