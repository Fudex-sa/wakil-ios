//
//  NewPasswordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol INewPasswordPresenter: class {
	// do someting...
}

class NewPasswordPresenter: INewPasswordPresenter {	
	weak var view: INewPasswordViewController?
	
	init(view: INewPasswordViewController?) {
		self.view = view
	}
}
