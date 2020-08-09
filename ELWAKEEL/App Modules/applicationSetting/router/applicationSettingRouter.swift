//
//  applicationSettingRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IapplicationSettingRouter: class {
	// do someting...
}

class applicationSettingRouter: IapplicationSettingRouter {	
	weak var view: applicationSettingViewController?
	
	init(view: applicationSettingViewController?) {
		self.view = view
	}
}
