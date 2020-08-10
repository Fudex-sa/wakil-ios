//
//  aboutUsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaboutUsPresenter: class {
    func assign_contact_Info(contact_info: aboutUsModel.About)
	// do someting...
}

class aboutUsPresenter: IaboutUsPresenter {
    func assign_contact_Info(contact_info: aboutUsModel.About) {
        view?.assignContact_info(contact_Info: contact_info)
    }
    
   
    
	weak var view: IaboutUsViewController?
	
	init(view: IaboutUsViewController?) {
		self.view = view
	}
}
