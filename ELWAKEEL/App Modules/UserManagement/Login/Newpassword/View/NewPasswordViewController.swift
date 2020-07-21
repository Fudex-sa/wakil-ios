//
//  NewPasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol INewPasswordViewController: class {
	var router: INewPasswordRouter? { get set }
    func showAlert(title: String, msg: String)
    func GoHome()
}

class NewPasswordViewController: UIViewController {
	var interactor: INewPasswordInteractor?
	var router: INewPasswordRouter?

    
    @IBOutlet weak var newPasswordLBL: UILabel!
    @IBOutlet weak var NewPassword2LBL: UILabel!
    @IBOutlet weak var newPasswordDES: UILabel!
    @IBOutlet weak var retypePasseword: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var retypePasswordTXT: UITextField!
    @IBOutlet weak var saveBTN: GradientButton!
    var phone = ""

    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        print("dddd\(phone)")
        passwordTXT.delegate = self
        retypePasswordTXT.delegate = self
        newPasswordLBL.text = Localization.newpassword
        NewPassword2LBL.text = Localization.newpassword
        newPasswordDES.text = Localization.newPasswordDES
        password.text = Localization.password
        retypePasseword.text = Localization.password
        saveBTN.setTitle(Localization.save, for: .normal)
    }
    
    @IBAction func backBTN(_ sender: Any) {
    
    dismiss()
    }
    
    @IBAction func saveBTN(_ sender: Any) {
        guard let password = passwordTXT.text,
            let confirmPassword = retypePasswordTXT.text
            else{
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
                return
                
        }
        
        if password != confirmPassword {
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.incorrectPassword, sender: self)
            return
        }
        else{
            
            interactor?.updatePassword(password: password, phone: phone)
        }
        
                
        }
        
    
    
}

extension NewPasswordViewController: INewPasswordViewController {
    func GoHome() {
        // Go Home
        print("GoHOme")
    }
    
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
	// do someting...
}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

extension NewPasswordViewController {
	// do someting...
}
