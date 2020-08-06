//
//  LOGINRequesterViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import MOLH

protocol ILOGINRequesterViewController: class {
	var router: ILOGINRequesterRouter? { get set }
    func showAlert(title: String, msg: String)
    func navigateToHome()
    func getUser(user: LOGINRequesterModel.loginSuccess)
}

class LOGINRequesterViewController: UIViewController {
	var interactor: ILOGINRequesterInteractor?
	var router: ILOGINRequesterRouter?

    @IBOutlet weak var logInBTN: UIButton!
    @IBOutlet weak var createNewAccount: UIButton!
    @IBOutlet weak var forgetpasswordBTN: UIButton!
    @IBOutlet weak var loginLBL: UILabel!
    @IBOutlet weak var loginNow: UILabel!
    @IBOutlet weak var loginDes: UILabel!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var phoneNumberLBL: UILabel!
    @IBOutlet weak var createNewAccountLBL: UILabel!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var passwordTXT: UITextField!
    var type = ""
    var user: LOGINRequesterModel.loginSuccess?
    var userDefualts = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        print("type\(type)")
        
}
    func setUpView()
    {
        print(Localization.login)
        loginLBL.text = Localization.login
        loginNow.text = Localization.loginNow
        loginDes.text = Localization.loginDes
        passwordLBL.text = Localization.password
        phoneNumberLBL.text = Localization.phoneNymber
        createNewAccountLBL.text = Localization.haveNotAccount
        logInBTN.setTitle(Localization.loginNow, for: .normal)
        forgetpasswordBTN.setTitle(Localization.forgetPaswwor, for: .normal)
        createNewAccount.setTitle(Localization.createAccount, for: .normal)
        createNewAccount.titleLabel?.adjustsFontSizeToFitWidth = true
        phoneTXT.delegate = self
        passwordTXT.delegate = self
        
        
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
   dismiss()
    }
    
    @IBAction func logINNow(_ sender: Any) {
        doLoginAction()
        
    }
    
    
    @IBAction func forgetPasswordBTN(_ sender: Any) {
        
       self.navigate(type: .modal, module: GeneralRouterRoute.forgetPassword, completion: nil)
    }
    
    
    
    @IBAction func CreateNewAccountBTn(_ sender: Any) {
        
        
        self.navigate(type: .modal, module: GeneralRouterRoute.registrationType
            , completion: nil)
        
    }
    
    func testGradientButton() -> Void {
        let gradientColor = CAGradientLayer()
        gradientColor.frame = logInBTN.frame
        gradientColor.colors = [UIColor.blue.cgColor,UIColor.red.withAlphaComponent(1).cgColor]
        self.logInBTN.layer.insertSublayer(gradientColor, at: 0)
    }

}
extension LOGINRequesterViewController{
    func doLoginAction(){
        guard let phone = phoneTXT.text , let password = passwordTXT.text else {return}
        if(phone.isEmpty || password.isEmpty || password.count < 4 || type == ""){
            showAlert(title: Localization.errorLBL, msg: Localization.wrongField)
            print(type)
            return
        
    }
        
        self.interactor?.dologin(phone: phone, password: password, type: type)
        print("goTointeractor")
    }
    
}



extension LOGINRequesterViewController: ILOGINRequesterViewController {
    func getUser(user: LOGINRequesterModel.loginSuccess) {
        self.user = user
        
        print("User\(user)")
    }
    
    func navigateToHome() {
        router?.navigateToHome()
    }
    
    func showAlert(title: String, msg: String) {
       
     ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
   
}

extension LOGINRequesterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
	// do someting...
}

extension LOGINRequesterViewController {
	// do someting...
}
