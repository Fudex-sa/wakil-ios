//
//  editRequestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestPresenter: class {
	// do someting...
}

class editRequestPresenter: IeditRequestPresenter {	
	weak var view: IeditRequestViewController?
	
	init(view: IeditRequestViewController?) {
		self.view = view
	}
}
