//
//  ForgetpasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IForgetpasswordViewController: class {
	var router: IForgetpasswordRouter? { get set }
}

class ForgetpasswordViewController: UIViewController {
	var interactor: IForgetpasswordInteractor?
	var router: IForgetpasswordRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension ForgetpasswordViewController: IForgetpasswordViewController {
	// do someting...
}

extension ForgetpasswordViewController {
	// do someting...
}

extension ForgetpasswordViewController {
	// do someting...
}
