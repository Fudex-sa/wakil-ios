//
//  change_nameViewController.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import MOLH
import LocalizationFramework

protocol Ichange_nameViewController: class {
	var router: Ichange_nameRouter? { get set }
}

class change_nameViewController: UIViewController {
	var interactor: Ichange_nameInteractor?
	var router: Ichange_nameRouter?

    
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var second_name: UITextField!
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        set_up_view()
        hideKeyboardWhenTappedAround()
    }
    
    func set_up_view(){
        nameLBL.text = Localization.change_name
        first_name.placeholder = Localization.first_name
        second_name.placeholder = Localization.last_name
        save.layer.cornerRadius = 10
        first_name.layer.cornerRadius = 10
        second_name.layer.cornerRadius = 10
        save.setTitle(Localization.save, for: .normal)
        first_name.delegate = self
        second_name.delegate = self
        if UserDefaults.standard.string(forKey: "type") == "provider"{
            save.backgroundColor = UIColor(red: 0.25, green: 0.27, blue: 0.60, alpha: 1.00)

        }
        else {
            save.backgroundColor = UIColor(red: 0.01, green: 0.60, blue: 0.58, alpha: 1.00)
            
        }
    }
    func validate_data()
    {
        guard let first_name = first_name.text, !first_name.isEmpty else{
            return
        }
        guard let last_name = second_name.text, !last_name.isEmpty else{
            return
        }
        
    }
    
    @IBAction func save_BTN(_ sender: Any) {
    }
    
}

extension change_nameViewController: Ichange_nameViewController {
	// do someting...
}

extension change_nameViewController {
	// do someting...
}

extension change_nameViewController: UITextFieldDelegate {
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
       }
}
