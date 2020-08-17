//
//  Provider_NotificationPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IProvider_NotificationPresenter: class {
	// do someting...
}

class Provider_NotificationPresenter: IProvider_NotificationPresenter {	
	weak var view: IProvider_NotificationViewController?
	
	init(view: IProvider_NotificationViewController?) {
		self.view = view
	}
}
