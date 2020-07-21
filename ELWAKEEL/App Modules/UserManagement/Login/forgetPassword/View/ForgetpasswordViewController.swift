//
//  ForgetpasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IForgetpasswordViewController: class {
	var router: IForgetpasswordRouter? { get set }
    func goverification(params: [String: Any])
    func showAlert(title: String, msg: String)
    
}

class ForgetpasswordViewController: UIViewController {
	var interactor: IForgetpasswordInteractor?
	var router: IForgetpasswordRouter?

    
    @IBOutlet weak var forgetPasswordLBL: UILabel!
    @IBOutlet weak var forgetPasswordLBL2: UILabel!
    @IBOutlet weak var forgetPasswordDEs: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var confirmBTN: UIButton!
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    func setUpView()
    {
        phoneTXT.delegate = self
        print(Localization.forgetPasswoedDEs)
        forgetPasswordLBL.text = Localization.forgetpassword
        forgetPasswordLBL2.text = Localization.forgetPaswwor
        forgetPasswordDEs.text = Localization.forgetPasswoedDEs
        phoneLBL.text = Localization.phoneNymber
        confirmBTN.setTitle(Localization.sendverificationCode, for: .normal)
    }
    
    
    @IBAction func confirmBTN(_ sender: Any) {
        
        guard let phone = phoneTXT.text else{
            
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            return
        }
        
        self.interactor?.forgetPassword(phone: phone)
      
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
    dismiss()
    }
    
}

extension ForgetpasswordViewController: IForgetpasswordViewController {
    func goverification(params: [String : Any]) {
       router?.goVerification(params: params)
    }
    
    
    
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
    
    
    
	// do someting...
}

extension ForgetpasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    // do someting...
}

extension ForgetpasswordViewController {
	// do someting...
}
