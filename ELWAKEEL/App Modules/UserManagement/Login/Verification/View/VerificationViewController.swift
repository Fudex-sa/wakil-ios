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
    func goNewPassword(type: String, id: Int)
    func CreateNewPassword(phone: String)
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
        
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
    
    dismiss()
    }
    
    
    @IBAction func resendBTN(_ sender: Any) {
        print("send again")
    }
    
    
    @IBAction func confirmBTN(_ sender: Any) {
     guard let num1 = firstNUM.text,
        let num2 = secondNUM.text,
        let num3 = thirdNum.text,
        let num4 = furthNUM.text
        else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            
            print("error Gurd")
            return
        }
         let number1 = Int(num1)
        let number2 = Int(num2)
        let number3 = Int(num3)
        let number4 = Int(num4)
        
        if number1 == 4 && number2 == 3 && number3 == 2 && number4 == 1{
            if type != nil || id != nil {
                goNewPassword(type: self.type!, id: self.id!)
            }
            else if phone != nil {
                CreateNewPassword(phone: phone!)
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
    func CreateNewPassword(phone: String) {
        router?.createNewPassword(phone: phone)
    }
    
    
    func goNewPassword(type: String, id: Int) {
        router?.goNewPassword(type: type, id: id)
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
