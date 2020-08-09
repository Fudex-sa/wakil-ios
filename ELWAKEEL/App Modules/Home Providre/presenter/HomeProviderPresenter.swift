//
//  HomeProviderPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderPresenter: class {
	// do someting...
}

class HomeProviderPresenter: IHomeProviderPresenter {	
	weak var view: IHomeProviderViewController?
	
	init(view: IHomeProviderViewController?) {
		self.view = view
	}
}
