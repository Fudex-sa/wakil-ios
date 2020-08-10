//
//  shareAPPViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IshareAPPViewController: class {
	var router: IshareAPPRouter? { get set }
}

class shareAPPViewController: UIViewController {
	var interactor: IshareAPPInteractor?
	var router: IshareAPPRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension shareAPPViewController: IshareAPPViewController {
	// do someting...
}

extension shareAPPViewController {
	// do someting...
}

extension shareAPPViewController {
	// do someting...
}
