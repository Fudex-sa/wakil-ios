//
//  change_addressViewController.swift
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

protocol Ichange_addressViewController: class {
	var router: Ichange_addressRouter? { get set }
}

class change_addressViewController: UIViewController {
	var interactor: Ichange_addressInteractor?
	var router: Ichange_addressRouter?

    
    @IBOutlet weak var addressTXT: UITextField!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var save: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        set_up_view()
        hideKeyboardWhenTappedAround()
    }
    
    func set_up_view()
    {
        addressTXT.delegate = self
        save.layer.cornerRadius = 7
        addressTXT.placeholder = Localization.address
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
            guard let address = addressTXT.text, !address.isEmpty else{
                return
            }
    }
    @IBAction func saveBTN(_ sender: Any) {
    }
    
}

extension change_addressViewController: Ichange_addressViewController {
	// do someting...
}

extension change_addressViewController {
	// do someting...
}

extension change_addressViewController: UITextFieldDelegate {
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
