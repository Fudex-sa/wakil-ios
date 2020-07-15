//
//  NewPasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol INewPasswordViewController: class {
	var router: INewPasswordRouter? { get set }
}

class NewPasswordViewController: UIViewController {
	var interactor: INewPasswordInteractor?
	var router: INewPasswordRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension NewPasswordViewController: INewPasswordViewController {
	// do someting...
}

extension NewPasswordViewController {
	// do someting...
}

extension NewPasswordViewController {
	// do someting...
}
