//
//  walletPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IwalletPresenter: class {
	// do someting...
}

class walletPresenter: IwalletPresenter {	
	weak var view: IwalletViewController?
	
	init(view: IwalletViewController?) {
		self.view = view
	}
}
