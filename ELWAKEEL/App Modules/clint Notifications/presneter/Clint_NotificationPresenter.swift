//
//  Clint_NotificationPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IClint_NotificationPresenter: class {
	// do someting...
}

class Clint_NotificationPresenter: IClint_NotificationPresenter {	
	weak var view: IClint_NotificationViewController?
	
	init(view: IClint_NotificationViewController?) {
		self.view = view
	}
}
