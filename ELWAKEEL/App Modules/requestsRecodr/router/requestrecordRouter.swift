//
//  requestrecordRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestrecordRouter: class {
	// do someting...
    
}

class requestrecordRouter: IrequestrecordRouter {	
	weak var view: requestrecordViewController?
	
	init(view: requestrecordViewController?) {
		self.view = view
	}
}
