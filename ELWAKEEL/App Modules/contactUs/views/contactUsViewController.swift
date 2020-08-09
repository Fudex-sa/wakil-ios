//
//  contactUsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsViewController: class {
	var router: IcontactUsRouter? { get set }
}

class contactUsViewController: UIViewController {
	var interactor: IcontactUsInteractor?
	var router: IcontactUsRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension contactUsViewController: IcontactUsViewController {
	// do someting...
}

extension contactUsViewController {
	// do someting...
}

extension contactUsViewController {
	// do someting...
}
