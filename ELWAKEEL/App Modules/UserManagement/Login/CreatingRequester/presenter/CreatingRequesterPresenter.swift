//
//  CreatingRequesterPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterPresenter: class {
	// do someting...
}

class CreatingRequesterPresenter: ICreatingRequesterPresenter {	
	weak var view: ICreatingRequesterViewController?
	
	init(view: ICreatingRequesterViewController?) {
		self.view = view
	}
}
