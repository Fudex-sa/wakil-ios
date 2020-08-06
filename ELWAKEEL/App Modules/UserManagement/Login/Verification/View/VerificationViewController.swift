//
//  VerificationViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IVerificationViewController: class {
	var router: IVerificationRouter? { get set }
  
    func goNewPassword(phone: String)
    func createPassword(type: String, id: Int)
    func goHome()
}

class VerificationViewController: UIViewController {
	var interactor: IVerificationInteractor?
	var router: IVerificationRouter?

    @IBOutlet weak var confirmLBL: UILabel!
    @IBOutlet weak var confirmDes: UILabel!
    @IBOutlet weak var resendLBL: UILabel!
    @IBOutlet weak var confirmBTN: UIButton!
    @IBOutlet weak var firstNUM: UITextField!
    @IBOutlet weak var secondNUM: UITextField!
    @IBOutlet weak var thirdNum: UITextField!
    @IBOutlet weak var furthNUM: UITextField!
    var type: String?
    var id: Int?
    var phone: String?
    var param: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
     
        
        type = param["type"] as? String
        phone = param["phone"] as? String
        id = param["id"] as? Int
        confirmLBL.text = Localization.confirmPhoneNumber
        confirmDes.text = Localization.confirmPhoneDes
        resendLBL.text = Localization.resendVerification
        confirmBTN.setTitle(Localization.confirmCode, for: .normal)
        resendLBL.adjustsFontSizeToFitWidth = true
        
        firstNUM.clipsToBounds = true
        secondNUM.clipsToBounds = true
        thirdNum.clipsToBounds = true
        furthNUM.clipsToBounds = true
        firstNUM.layer.cornerRadius = 10.0
        secondNUM.layer.cornerRadius = 10.0
        thirdNum.layer.cornerRadius = 10.0
        furthNUM.layer.cornerRadius = 10.0
        firstNUM.delegate = self
        secondNUM.delegate = self
        thirdNum.delegate = self
        furthNUM.delegate = self
        firstNUM.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        secondNUM.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        thirdNum.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        furthNUM.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

        
        
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if text?.count == 1 {
            switch textField{
            case furthNUM:
                thirdNum.becomeFirstResponder()
            case thirdNum:
                secondNUM.becomeFirstResponder()
            case secondNUM:
                firstNUM.becomeFirstResponder()
            case firstNUM:
                firstNUM.resignFirstResponder()
            default:
                break
            }
        }

        else{
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
    
    dismiss()
    }
    
    
    @IBAction func resendBTN(_ sender: Any) {
        print("send again")
    }
    
    
    @IBAction func confirmBTN(_ sender: Any) {
     guard let num4 = firstNUM.text,
        let num3 = secondNUM.text,
        let num2 = thirdNum.text,
        let num1 = furthNUM.text,
        !num1.isEmpty || !num2.isEmpty || !num3.isEmpty || !num4.isEmpty
        else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            
            print("error Gurd")
            return
        }
         let number1 = Int(num1)
        let number2 = Int(num2)
        let number3 = Int(num3)
        let number4 = Int(num4)
        
        if number1 == 1 && number2 == 2 && number3 == 3 && number4 == 4{
            if type == "provider" {
                print("provider")
                self.goHome()
 
            }
            else if type == "client" {
                print("client")
                self.createPassword(type: type!, id: id!)
            }
            else {
                print("forget password")
                self.goNewPassword(phone: phone!)
            }
            
        }
        else{
            print("error")
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.correctVerificationNumber, sender: self)
            return
        }
       
    }
    
    
    
}

extension VerificationViewController: IVerificationViewController {
    func goHome() {
        router?.goHome()
    }
    
    func goNewPassword(phone: String) {
        router?.goNewpassword(phone: phone)
    }
    
    func createPassword(type: String, id: Int) {
        router?.createpassword(type: type, id: id)
    }
    
    
    
    
    
	// do someting...
}

extension VerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
   
}

extension VerificationViewController {
	// do someting...
}
