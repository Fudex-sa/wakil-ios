//
//  CreatingRequesterRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterRouter: class {
	// do someting...
    func GoVerification(type: String, id: Int)
    
}

class CreatingRequesterRouter: ICreatingRequesterRouter {
    func GoVerification(type: String, id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.verification(params: ["type":type, "id": id]), completion: nil)
    }
    
	weak var view: CreatingRequesterViewController?
	
	init(view: CreatingRequesterViewController?) {
		self.view = view
	}
}
