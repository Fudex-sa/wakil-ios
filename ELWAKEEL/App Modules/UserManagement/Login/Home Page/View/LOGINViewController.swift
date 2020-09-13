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
import LocalizationFramework
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
    let user_default = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        print(Localization.serviceproviders)
       titleLBL.text = Localization.usertype
        descriptionLBL.text = Localization.userTypeDes
        serviceSupplier.setTitle(Localization.serviceproviders, for: .normal)
        ServiceRequester.setTitle(Localization.serviceRequester, for: .normal)
      
        
        
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
    
    dismiss()
    }
    
    @IBAction func servicesRequesterBTN(_ sender: Any) {
        user_default.set("client", forKey: "type")
       
        self.navigate(type: .modal, module: GeneralRouterRoute.login(type: "client"), completion: nil)
        
    }
    
    
    
    @IBAction func servicesProviderBTN(_ sender: UIButton) {
        user_default.set("provider", forKey: "type")

        self.navigate(type: .modal, module: GeneralRouterRoute.login(type: "provider"), completion: nil)
        
    }
    
    
}
extension LOGINViewController{
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print(msg)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("error")
            }}))
    
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
