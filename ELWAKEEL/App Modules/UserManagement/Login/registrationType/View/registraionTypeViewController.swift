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
import LocalizationFramework
protocol IregistraionTypeViewController: class {
	var router: IregistraionTypeRouter? { get set }
}

class registraionTypeViewController: UIViewController {
	var interactor: IregistraionTypeInteractor?
	var router: IregistraionTypeRouter?

    
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var requesterBTN: UIButton!
    @IBOutlet weak var providerBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    func setUpView()
    {
        print(Localization.serviceproviders)
        titleLBL.text = Localization.usertype
        descriptionLB.text = Localization.userTypeDes
        providerBTN.setTitle(Localization.serviceproviders, for: .normal)
        requesterBTN.setTitle(Localization.serviceRequester, for: .normal)
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
    
    dismiss()
    }
    
    @IBAction func ReuesterBTN(_ sender: Any) {
self.navigate(type: .modal, module: GeneralRouterRoute.LoginRequester(type: "client"), completion: nil)
        
    }
    
    @IBAction func providerBTN(_ sender: Any) {
        self.navigate(type: .modal, module: GeneralRouterRoute.supplierFirst(type: "provider"), completion: nil)
        
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
