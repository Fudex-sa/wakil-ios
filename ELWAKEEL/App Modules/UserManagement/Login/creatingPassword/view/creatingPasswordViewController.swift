//
//  creatingPasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcreatingPasswordViewController: class {
	var router: IcreatingPasswordRouter? { get set }
}

class creatingPasswordViewController: UIViewController {
	var interactor: IcreatingPasswordInteractor?
	var router: IcreatingPasswordRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension creatingPasswordViewController: IcreatingPasswordViewController {
	// do someting...
}

extension creatingPasswordViewController {
	// do someting...
}

extension creatingPasswordViewController {
	// do someting...
}
