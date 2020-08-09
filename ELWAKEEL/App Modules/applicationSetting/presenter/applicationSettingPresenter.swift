//
//  applicationSettingPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IapplicationSettingPresenter: class {
	// do someting...
}

class applicationSettingPresenter: IapplicationSettingPresenter {	
	weak var view: IapplicationSettingViewController?
	
	init(view: IapplicationSettingViewController?) {
		self.view = view
	}
}
