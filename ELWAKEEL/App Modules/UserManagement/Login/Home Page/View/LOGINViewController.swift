//
//  LOGINViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINViewController: class {
	var router: ILOGINRouter? { get set }
}

class LOGINViewController: UIViewController {
	var interactor: ILOGINInteractor?
	var router: ILOGINRouter?

    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var backBTN: UIButton!
    
    @IBOutlet weak var descriptionLBL: UILabel!
    
    @IBOutlet weak var ServiceRequester: UIButton!
    
    @IBOutlet weak var serviceSupplier: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension LOGINViewController: ILOGINViewController {
	// do someting...
}

extension LOGINViewController {
	// do someting...
}

extension LOGINViewController {
	// do someting...
}
