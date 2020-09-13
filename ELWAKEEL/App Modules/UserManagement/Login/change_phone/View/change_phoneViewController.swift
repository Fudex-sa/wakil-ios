//
//  change_phoneViewController.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol Ichange_phoneViewController: class {
	var router: Ichange_phoneRouter? { get set }
}

class change_phoneViewController: UIViewController {
	var interactor: Ichange_phoneInteractor?
	var router: Ichange_phoneRouter?

    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var save: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        set_up_view()
    }
    
    func set_up_view()
    {
        phoneLBL.text = Localization.change_phone
        phoneTXT.placeholder = Localization.phone
        save.layer.cornerRadius = 7
        save.setTitle(Localization.save, for: .normal)
        if UserDefaults.standard.string(forKey: "type") == "provider"{
            save.backgroundColor = UIColor(red: 0.25, green: 0.27, blue: 0.60, alpha: 1.00)
            
        }
        else {
            save.backgroundColor = UIColor(red: 0.01, green: 0.60, blue: 0.58, alpha: 1.00)
            
        }
    }
    func validate_data()
    {
        guard let phone = phoneTXT.text, !phone.isEmpty else{
            return
        }
    }
    
    @IBAction func saveBTN(_ sender: Any) {
    }
    
}

extension change_phoneViewController: Ichange_phoneViewController {
	// do someting...
}

extension change_phoneViewController {
	// do someting...
}

extension change_phoneViewController: UITextFieldDelegate {
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
	// do someting...
}
