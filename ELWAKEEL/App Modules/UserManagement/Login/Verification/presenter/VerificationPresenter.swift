//
//  VerificationPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IVerificationPresenter: class {
	// do someting...
}

class VerificationPresenter: IVerificationPresenter {	
	weak var view: IVerificationViewController?
	
	init(view: IVerificationViewController?) {
		self.view = view
	}
}
