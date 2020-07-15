//
//  CreatingRequesterViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterViewController: class {
	var router: ICreatingRequesterRouter? { get set }
}

class CreatingRequesterViewController: UIViewController {
	var interactor: ICreatingRequesterInteractor?
	var router: ICreatingRequesterRouter?

    
    @IBOutlet weak var checkBTN: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    func setUpView()
    {
        checkBTN.layer.borderWidth = 2
        checkBTN.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.00).cgColor
    }
}

extension CreatingRequesterViewController: ICreatingRequesterViewController {
	// do someting...
}

extension CreatingRequesterViewController {
	// do someting...
}

extension CreatingRequesterViewController {
	// do someting...
}
