//
//  termsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ItermsViewController: class {
	var router: ItermsRouter? { get set }
}

class termsViewController: UIViewController {
	var interactor: ItermsInteractor?
	var router: ItermsRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension termsViewController: ItermsViewController {
	// do someting...
}

extension termsViewController {
	// do someting...
}

extension termsViewController {
	// do someting...
}
