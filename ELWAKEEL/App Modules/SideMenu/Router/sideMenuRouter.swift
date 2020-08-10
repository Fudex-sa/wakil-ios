//
//  sideMenuRouter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuRouter: class {
	// do someting...
    func main()
    func record_requests()
    func application_Setting()
    func connect_with_us()
    func about_the_application()
    func common_question()
    func terms_and_conditions()
    func login()
    
}

class sideMenuRouter: IsideMenuRouter {
    func login() {
        
        let userDefualts = UserDefaults.standard
        userDefualts.set(false, forKey: "login")
        view?.navigate(type: .modal, module: GeneralRouterRoute.LoginRequester(type: UserDefaults.standard.string(forKey: "type")!), completion: nil)
    }
    
    func record_requests() {
        print("ssss")
        view?.navigate(type: .modal, module: GeneralRouterRoute.requestsRecord, completion: nil)
    }
    
    func application_Setting() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.applicationSetting, completion: nil)

        print("ssss")

    }
    
    func connect_with_us() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.contactUs, completion: nil)

        print("ssss")

    }
    
    func about_the_application() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.aboutUs, completion: nil)

        print("ssss")

    }
    
    func common_question() {
        print("ssss")
        view?.navigate(type: .modal, module: GeneralRouterRoute.commonQuestios, completion: nil)

    }
    
    
    
    func terms_and_conditions() {
        print("ssss")
        view?.navigate(type: .modal, module: GeneralRouterRoute.terms, completion: nil)


    }
    
    func main() {
        view?.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
	weak var view: sideMenuViewController?
	
	init(view: sideMenuViewController?) {
		self.view = view
	}
}
