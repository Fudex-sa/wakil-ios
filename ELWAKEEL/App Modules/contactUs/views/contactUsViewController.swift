//
//  contactUsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import RSSelectionMenu

protocol IcontactUsViewController: class {
	var router: IcontactUsRouter? { get set }
    func alert()
    func backHome()
    func errorAlert()
    
}

class contactUsViewController: UIViewController {
	var interactor: IcontactUsInteractor?
	var router: IcontactUsRouter?

    @IBOutlet weak var contactUs: UILabel!
    @IBOutlet weak var contactUsNow: UILabel!
    @IBOutlet weak var contactUsDES: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var contactType: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTex: UITextField!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var contactTypeTXT: UITextField!
    @IBOutlet weak var mmessageViwe: UITextView!
    @IBOutlet weak var send: UIButton!
    var placeholderLabel : UILabel!
    var types: [String] = [Localization.request, Localization.complaint1, Localization.suggestion, Localization.other]
    var selecte_type: [String] = [String]()
    var selectedType = ""
    let user_default = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        hideKeyboardWhenTappedAround()
        set_up_navigation()
    }
    func setUpView()
    {
        name.text = Localization.name
        email.text = Localization.email
        contactUsNow.text = Localization.contactUsNow
        contactUsDES.text = Localization.contactDES
        phone.text = Localization.phone
        contactType.text = Localization.contactType
        message.text = Localization.message
        send.titleLabel?.text = Localization.send
        
        mmessageViwe.delegate = self
        mmessageViwe.layer.borderWidth = 1
        mmessageViwe.layer.borderColor = UIColor.lightGray.cgColor
        nameTxt.delegate = self
        emailTex.delegate = self
        contactTypeTXT.delegate = self
        phoneTXT.delegate = self
 
        
        
    }
    func set_up_navigation()
       {     self.navigationItem.title = Localization.contactUS
           if user_default.string(forKey: "type") == "provider" {
               self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)

               
           }
           else {
               self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)

           }
           
       }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if text?.count == 1 {
            switch textField{
            case nameTxt:
                emailTex.becomeFirstResponder()
            case emailTex:
                phoneTXT.becomeFirstResponder()
            case phoneTXT:
                contactTypeTXT.becomeFirstResponder()
            case contactTypeTXT:
                contactTypeTXT.resignFirstResponder()
            default:
                break
            }
        }
            
        else{
        }
    }
    
  

    
    @IBAction func sendBTN(_ sender: Any) {
        validate()
        let name = nameTxt.text!
        let email = emailTex.text!
        let subject = contactTypeTXT.text!
        let content = mmessageViwe.text!
        let phone = phoneTXT.text!
        self.interactor?.contact(email: email, name: name, subject: subject, content: content, phone: phone)
        
    }
    
    
    @IBAction func show_side_menu(_ sender: Any) {
        router?.show_side_menu()
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        let sendAction = UIAlertAction(title: Localization.ok, style: .cancel) { (action) in
            
        }
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(sendAction)
        
        present(alert, animated: true, completion: nil)
    }
    func validate()
    {
        if nameTxt.text?.isEmpty == true
        {
            nameTxt.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
        }
         if emailTex.text?.isEmpty == true{
           emailTex.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
        }
         if phoneTXT.text?.isEmpty == true{
            phoneTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
        }
         if contactTypeTXT.text?.isEmpty == true{
            contactTypeTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
        }
         if mmessageViwe.text?.isEmpty == true{
            showAlert(title: Localization.errorLBL, message: Localization.requirdField)
           
          
        }
    }
    
    func contactTypes()
    {
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: types) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selecte_type) {[weak self] (item, index, isselected, selectedItem) in
            self?.selecte_type = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: Localization.contactType, action: "ok", height: 150), from: self)
        menu.onDismiss = { [weak self] items in
            self?.selectedType = (self?.selecte_type[0])!
            self?.contactTypeTXT.text = self?.selectedType
            
            
        }
    }
}
    


extension contactUsViewController: IcontactUsViewController {
    
    func errorAlert() {
        showAlert(title: Localization.errorLBL, message: Localization.thereiserror)
        
    }
    
    
    func backHome() {
        router?.backHome()
    }
    
    func alert() {
        let alert = AlertController(title: "" , message: Localization.complaint, preferredStyle: .alert)
        
        let sendAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
          self.backHome()
            
        }
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(sendAction)
        
        present(alert, animated: true, completion: nil)
    }
    
	// do someting...
}

extension contactUsViewController: UITextViewDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension contactUsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)

        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if textField == contactTypeTXT{
            
            contactTypes()
        }
        else{
           return true
        }
        return false

    }
    
}
