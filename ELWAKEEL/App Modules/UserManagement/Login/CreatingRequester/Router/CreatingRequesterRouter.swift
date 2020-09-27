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
    func move_to_terms()
}

class CreatingRequesterRouter: ICreatingRequesterRouter {
    func move_to_terms() {
            view?.navigate(type: .push, module: GeneralRouterRoute.terms, completion: nil)
           
    }
    
    func GoVerification(type: String, id: Int) {
        view?.navigate(type: .push, module: GeneralRouterRoute.verification(params: ["type":type, "id": id]), completion: nil)
    }
    
	weak var view: CreatingRequesterViewController?
	
	init(view: CreatingRequesterViewController?) {
		self.view = view
	}
}
