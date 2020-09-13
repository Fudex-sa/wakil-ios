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
    func client_Home()
    func provider_Home()
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
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var passwordTXT: UITextField!
    var type = ""
    var user: LOGINRequesterModel.loginSuccess?
    var userDefualts = UserDefaults.standard
    let navigation = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        print("type\(type)")
        
}
    func setUpView()
    {
        loginNow.text = Localization.loginNow
        loginDes.text = Localization.loginDes
        passwordLBL.text = Localization.password
        phoneNumberLBL.text = Localization.phoneNymber
        createNewAccountLBL.text = Localization.haveNotAccount
        logInBTN.setTitle(Localization.loginNow, for: .normal)
        forgetpasswordBTN.setTitle(Localization.forgetPaswwor, for: .normal)
        createNewAccount.setTitle(Localization.createAccount, for: .normal)
        createNewAccount.titleLabel?.adjustsFontSizeToFitWidth = true
        phone.delegate = self
        passwordTXT.delegate = self
        
        let window = UIApplication.shared.delegate?.window
                     
        let navigationVC = UINavigationController(rootViewController: self)

        navigationVC.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationVC.navigationBar.topItem?.title = Localization.login
                   window?!.rootViewController = navigationVC
                   window?!.makeKeyAndVisible()

        
    }
    
    
    @IBAction func logINNow(_ sender: Any) {
//        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
//        MOLH.reset()
        doLoginAction()
//        
    }
    
    
    @IBAction func forgetPasswordBTN(_ sender: Any) {
        
       self.navigate(type: .push, module: GeneralRouterRoute.forgetPassword, completion: nil)
    }
    
    
    
    @IBAction func CreateNewAccountBTn(_ sender: Any) {
        
        
        self.navigate(type: .push, module: GeneralRouterRoute.registrationType
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
        guard let phone_number = phone.text, !phone_number.isEmpty  else{
            showAlert(title: Localization.errorLBL, msg: Localization.phone_count)
            return
        }
        guard  let password = passwordTXT.text, !password.isEmpty else {
            showAlert(title: Localization.errorLBL, msg: Localization.password_conut)
            
            return}
       
        let te = UserDefaults.standard.string(forKey: "type")
        print("sss\(te)")
        if let te = te{
             self.interactor?.dologin(phone: phone_number, password: password)
        }
       
    }
    
}



extension LOGINRequesterViewController: ILOGINRequesterViewController {
    func provider_Home() {
        router?.provider_Home()
    }
    
    func getUser(user: LOGINRequesterModel.loginSuccess) {
        self.user = user
        
    }
    
    func client_Home() {
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

