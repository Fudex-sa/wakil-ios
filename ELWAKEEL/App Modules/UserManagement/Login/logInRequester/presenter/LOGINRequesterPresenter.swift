//
//  LOGINRequesterPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRequesterPresenter: class {
	// do someting...
}

class LOGINRequesterPresenter: ILOGINRequesterPresenter {	
	weak var view: ILOGINRequesterViewController?
	
	init(view: ILOGINRequesterViewController?) {
		self.view = view
	}
}
