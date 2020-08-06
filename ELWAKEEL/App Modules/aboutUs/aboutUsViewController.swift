//
//  aboutUsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import RSSelectionMenu

protocol IaboutUsViewController: class {
	var router: IaboutUsRouter? { get set }
}

class aboutUsViewController: UIViewController {
	var interactor: IaboutUsInteractor?
	var router: IaboutUsRouter?
    var items: [String] = ["hamada","mohamed","ali","ahmed","mostafa"]
    var selectedItems: [String] = [String]()
    var delegate: SocialControllerDelegate?
    var container: ContainerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        
    }
    
    
    @IBAction func bbb(_ sender: Any) {
        print("bbbb")
        container = ContainerController()
        delegate?.handleMenuToggle()
    }
    
    
    
}

extension aboutUsViewController: IaboutUsViewController {
	// do someting...
}

extension aboutUsViewController {
	// do someting...
}

extension aboutUsViewController {
	// do someting...
}
