//
//  change_passwordViewController.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import MOLH

protocol Ichange_passwordViewController: class {
	var router: Ichange_passwordRouter? { get set }
}

class change_passwordViewController: UIViewController {
	var interactor: Ichange_passwordInteractor?
	var router: Ichange_passwordRouter?

    @IBOutlet weak var password_edit: UILabel!
    @IBOutlet weak var ole_password: UITextField!
    @IBOutlet weak var new_password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        set_up_view()
        hideKeyboardWhenTappedAround()
    }
    func set_up_view(){
        save.layer.cornerRadius = 8
        ole_password.layer.cornerRadius = 10
        new_password.layer.cornerRadius = 10
        confirm_password.layer.cornerRadius = 10
        ole_password.placeholder = Localization.old_password
        new_password.placeholder = Localization.new_password
        confirm_password.placeholder = Localization.new_password
        password_edit.text = Localization.edit_password
        save.setTitle(Localization.save, for: .normal)
        if UserDefaults.standard.string(forKey: "type") == "provider"{
            save.backgroundColor = UIColor(red: 0.25, green: 0.27, blue: 0.60, alpha: 1.00)
            
        }
        else {
            save.backgroundColor = UIColor(red: 0.01, green: 0.60, blue: 0.58, alpha: 1.00)
            
            
        }
        
        ole_password.delegate = self
        new_password.delegate = self
        confirm_password.delegate = self
        
        
    }
    func validate_data()
    {
        guard let old_password = ole_password.text, !old_password.isEmpty else{
            return
        }
        guard let new_password = new_password.text, !new_password.isEmpty else{
            return
        }
        guard let confirm_password = confirm_password.text, !confirm_password.isEmpty else{
            return
        
    }
        if new_password != confirm_password{
            
        }
    
}
    
    @IBAction func save(_ sender: Any) {
    }
    
}

extension change_passwordViewController: Ichange_passwordViewController {
	// do someting...
}

extension change_passwordViewController {
	// do someting...
}

extension change_passwordViewController: UITextFieldDelegate {
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
           // do someting...
       }
}
