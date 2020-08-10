//
//  sideMenuProviderRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuProviderRouter: class {
	// do someting...
    func GO_terms()
    func GO_home()
    func Go_contact_us()
    func FQA()
    func About_app()
    func Records()
    func App_setting()
    func GO_wallet()
}

class sideMenuProviderRouter: IsideMenuProviderRouter {
    func GO_wallet() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.wallet, completion: nil)
    }
    
    func App_setting() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.applicationSetting, completion: nil)
    }
    
    func GO_terms() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.terms, completion: nil)
    }
    
    func GO_home() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
    func Go_contact_us() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.contactUs, completion: nil)
    }
    
    func FQA() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.commonQuestios, completion: nil)
    }
    
    func About_app() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.aboutUs, completion: nil)
    }
    
    func Records() {
    view?.navigate(type: .modal, module: GeneralRouterRoute.requestsRecord, completion: nil)
    }
    
	weak var view: sideMenuProviderViewController?
	
	init(view: sideMenuProviderViewController?) {
		self.view = view
	}
}
