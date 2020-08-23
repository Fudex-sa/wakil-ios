//
//  accept_reuestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iaccept_reuestPresenter: class {
	// do someting...
    func go_home()
}

class accept_reuestPresenter: Iaccept_reuestPresenter {
        func go_home() {
            view?.go_home()
        }
	weak var view: Iaccept_reuestViewController?
	
	init(view: Iaccept_reuestViewController?) {
		self.view = view
	}
}
