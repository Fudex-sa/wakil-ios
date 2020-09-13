//
//  creatingPasswordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
protocol IcreatingPasswordViewController: class {
	var router: IcreatingPasswordRouter? { get set }
    func showAlert(title: String, msg: String)
    func assignResponse(newClient: creatingPasswordModel.NewClient)
    func goHome()
}

class creatingPasswordViewController: UIViewController {
	var interactor: IcreatingPasswordInteractor?
	var router: IcreatingPasswordRouter?

    
    @IBOutlet weak var accountPasswordDes: UILabel!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var accountPassword: UILabel!
    @IBOutlet weak var passwrdLBL: UILabel!
    @IBOutlet weak var reTypePassword: UILabel!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var retypePassword: UITextField!
    @IBOutlet weak var loginNowBTN: GradientButton!
    
    var type = ""
    var id = 0
    var newclient: creatingPasswordModel.NewClient?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        print("RRRRR\(type)\(id)")
//        passwordLBL.text =
        accountPassword.text = Localization.passwordAccount
        accountPasswordDes.text = Localization.accountpasswordDes
        passwrdLBL.text = Localization.password
        reTypePassword.text = Localization.retypePassword
        
        loginNowBTN.setTitle(Localization.enterNow, for: .normal)
        passwordTXT.delegate = self
        retypePassword.delegate = self
        self.navigationItem.title = Localization.password
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Localization.password
    }
    @IBAction func backBTN(_ sender: Any) {
    
    dismiss()
    }
    
    
    @IBAction func loginBTN(_ sender: Any) {
    
        guard let password = passwordTXT.text, !password.isEmpty,
            let confirmidPassword = retypePassword.text, !confirmidPassword.isEmpty else{
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            return

        }

        if password != confirmidPassword {
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.incorrectPassword, sender: self)
            return
        }
        else{
            self.interactor?.creatingPassword(password: password, type: type, id: id)

        }
        
    }
    
}

extension creatingPasswordViewController: IcreatingPasswordViewController {
    func goHome() {
        // Go To home Scerren
        
        self.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
    func assignResponse(newClient: creatingPasswordModel.NewClient) {
        self.newclient = newClient
    }
    
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
    
	// do someting...
}

extension creatingPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

extension creatingPasswordViewController {
	// do someting...
}
