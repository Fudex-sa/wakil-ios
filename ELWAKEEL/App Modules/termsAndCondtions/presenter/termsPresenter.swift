//
//  termsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ItermsPresenter: class {
	// do someting...
    func assign_terms(terms: termsModel.Terms)
}

class termsPresenter: ItermsPresenter {
    func assign_terms(terms: termsModel.Terms) {
        view?.assignTerms(trems: terms )
    }
    
	weak var view: ItermsViewController?
	
	init(view: ItermsViewController?) {
		self.view = view
	}
}
