//
//  commonQuestionsRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcommonQuestionsRouter: class {
	// do someting...
}

class commonQuestionsRouter: IcommonQuestionsRouter {	
	weak var view: commonQuestionsViewController?
	
	init(view: commonQuestionsViewController?) {
		self.view = view
	}
}
