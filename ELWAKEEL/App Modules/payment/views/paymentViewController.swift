//
//  paymentViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IpaymentViewController: class {
	var router: IpaymentRouter? { get set }
    func go_request_details()
}

class paymentViewController: UIViewController {
	var interactor: IpaymentInteractor?
	var router: IpaymentRouter?

    
    @IBOutlet weak var electronic_payment: UILabel!
    @IBOutlet weak var electronic_payment2: UILabel!
    @IBOutlet weak var price_Des: UILabel!
    @IBOutlet weak var bank_name: UILabel!
    @IBOutlet weak var iban_number: UILabel!
    @IBOutlet weak var pay_now: GradientButton!
    @IBOutlet weak var ibanTXT: UITextField!
    @IBOutlet weak var bankTXT: UITextField!
    
    var offer_id: Int?
    var request_id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        hideKeyboardWhenTappedAround()
        print("token\(UserDefaults.standard.string(forKey: "token"))")
        print("ofer_id\(offer_id) \(request_id)")
    }
    func setUpView(){
        electronic_payment.text = Localization.electronic_payment
        electronic_payment2.text = Localization.electronic_payment
        price_Des.text = Localization.electronic_payment_Des
        bank_name.text = Localization.bankName + "*"
        iban_number.text = Localization.IBANNumber + "*"
        pay_now.setTitle(Localization.pay_now, for: .normal)
    }
    
    @IBAction func pay_now(_ sender: Any) {
        validate_data()
    }
    func validate_data()
    {
        guard let bank_name = bankTXT.text, !bank_name.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_bank_name, sender: self)
            bankTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        
        guard let iban_number = ibanTXT.text, !iban_number.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_iban_number, sender: self)
            ibanTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        if  let offer_id = offer_id
        {
            let iban_num = Int(iban_number)
            interactor?.accept_offer(bank_name: bank_name, iban_num: iban_num!, offer_num: offer_id)
        }
        
        
        
    }
    
}

extension paymentViewController: IpaymentViewController {
    func go_request_details() {
        print("request_id\(request_id)")
        if let request_id = request_id {
            router?.go_request_details(request_id: request_id)

        }
    }
    
	// do someting...
}

extension paymentViewController: UITextFieldDelegate {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
	// do someting...
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension paymentViewController {
	// do someting...
}
