//
//  registraionTypePresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IregistraionTypePresenter: class {
	// do someting...
}

class registraionTypePresenter: IregistraionTypePresenter {	
	weak var view: IregistraionTypeViewController?
	
	init(view: IregistraionTypeViewController?) {
		self.view = view
	}
}
