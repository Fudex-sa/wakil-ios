//
//  contactUsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsPresenter: class {
	// do someting...
}

class contactUsPresenter: IcontactUsPresenter {	
	weak var view: IcontactUsViewController?
	
	init(view: IcontactUsViewController?) {
		self.view = view
	}
}
