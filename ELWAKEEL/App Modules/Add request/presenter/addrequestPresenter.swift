//
//  addrequestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaddrequestPresenter: class {
    func assignOrganization(organizations: [addrequestModel.Organization])
	// do someting...
}

class addrequestPresenter: IaddrequestPresenter {
    func assignOrganization(organizations: [addrequestModel.Organization]) {
        view?.assignorganization(organizations: organizations)
    }
    
	weak var view: IaddrequestViewController?
	
	init(view: IaddrequestViewController?) {
		self.view = view
	}
}
