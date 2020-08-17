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
    func show_side_menu()
	// do someting...
}

class commonQuestionsRouter: IcommonQuestionsRouter {
    func show_side_menu() {
        if UserDefaults.standard.string(forKey: "type")  == "provider"
        {
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenuProvider, completion: nil)
            
        }
        else{
            view?.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
        }
        
    }
    
	weak var view: commonQuestionsViewController?
	
	init(view: commonQuestionsViewController?) {
		self.view = view
	}
}
