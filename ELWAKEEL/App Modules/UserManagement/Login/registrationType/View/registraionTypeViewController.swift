//
//  registraionTypeViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IregistraionTypeViewController: class {
	var router: IregistraionTypeRouter? { get set }
}

class registraionTypeViewController: UIViewController {
	var interactor: IregistraionTypeInteractor?
	var router: IregistraionTypeRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension registraionTypeViewController: IregistraionTypeViewController {
	// do someting...
}

extension registraionTypeViewController {
	// do someting...
}

extension registraionTypeViewController {
	// do someting...
}
