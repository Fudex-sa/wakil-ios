//
//  change_cityViewController.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_cityViewController: class {
	var router: Ichange_cityRouter? { get set }
}

class change_cityViewController: UIViewController {
	var interactor: Ichange_cityInteractor?
	var router: Ichange_cityRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension change_cityViewController: Ichange_cityViewController {
	// do someting...
}

extension change_cityViewController {
	// do someting...
}

extension change_cityViewController {
	// do someting...
}
