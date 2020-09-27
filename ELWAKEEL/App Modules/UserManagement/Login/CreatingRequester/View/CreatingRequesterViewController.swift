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
import LocalizationFramework

protocol ICreatingRequesterViewController: class {
	var router: ICreatingRequesterRouter? { get set }
    func goVerification(type: String, id: Int)
    func showAlert(title: String, msg: String)
    func assingModel(model: CreatingRequesterModel.registerCleint)
}

class CreatingRequesterViewController: UIViewController {
	var interactor: ICreatingRequesterInteractor?
	var router: ICreatingRequesterRouter?

    
    
    @IBOutlet weak var newAccount: UILabel!
    @IBOutlet weak var createNewAccount: UILabel!
    @IBOutlet weak var createAccountDes: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var conditonsLBL: UILabel!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var checkBTN: UIButton!
    @IBOutlet weak var sendDataBTN: UIButton!
    var unchecked = true
    var type: String = ""
    var newClient: CreatingRequesterModel.registerCleint?
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        hideKeyboardWhenTappedAround()
    }
    func setUpView()
    {
         phoneTXT.delegate = self
//        newAccount.text = Localization.newAccount
        createNewAccount.text = Localization.createAccount
        createAccountDes.text = Localization.insertPtoneNum
        phoneNumber.text = Localization.phoneNymber
        conditonsLBL.text = Localization.conditions
       
       print(Localization.conditions)
        conditonsLBL.adjustsFontSizeToFitWidth = true
        checkBTN.layer.borderWidth = 2
        checkBTN.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.00).cgColor
        
        sendDataBTN.setTitle(Localization.send, for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.Go_terms))
        conditonsLBL.addGestureRecognizer(tap)
        
        
    }
    @objc func Go_terms() {
        print("tap working")
        self.router?.move_to_terms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
                self.navigationItem.title = Localization.newAccount
            self.navigationController?.navigationBar.isHidden = false

           }
    
    
    @IBAction func checkBTN(_ sender: UIButton) {
        
        if unchecked {
            sender.setImage(UIImage(named:"check"), for: .normal)
            unchecked = false
        }
        else {
            sender.setImage( UIImage(named:""), for: .normal)
            unchecked = true
        }
    }
   
    
    @IBAction func sendDataBTN(_ sender: Any) {
        
        guard let phone = phoneTXT.text else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            return
        }
        if phone.count < 7{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.phoneverfiy, sender: self)
            return
        }
        if unchecked == true{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.acceptTerms, sender: self)
            return
        }
        self.interactor?.signUP(phone: phone)

    }

}

extension CreatingRequesterViewController: ICreatingRequesterViewController {
    func goVerification(type: String, id: Int) {
        router?.GoVerification(type: type, id: id)
    }
    
    func assingModel(model: CreatingRequesterModel.registerCleint) {
        self.newClient = model
    }
    
    
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
   
    
	// do someting...
}

extension CreatingRequesterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         self.view.endEditing(true)
                  return false    }
           func hideKeyboardWhenTappedAround() {
                  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                  tap.cancelsTouchesInView = false
                  view.addGestureRecognizer(tap)
              }
              
              @objc func dismissKeyboard() {
             view.endEditing(true)
                  // dosometing...
              }    
    
	// do someting...
}

extension CreatingRequesterViewController {
	// do someting...
}
