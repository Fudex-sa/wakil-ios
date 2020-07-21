//
//  HomePresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomePresenter: class {
	// do someting...
}

class HomePresenter: IHomePresenter {	
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
}
