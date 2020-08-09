//
//  applicationSettingViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import RSSelectionMenu
import LocalizationFramework

protocol IapplicationSettingViewController: class {
	var router: IapplicationSettingRouter? { get set }
}

class applicationSettingViewController: UIViewController {
	var interactor: IapplicationSettingInteractor?
	var router: IapplicationSettingRouter?

    
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var selectlan: UILabel!
    
    
    @IBOutlet weak var main: UILabel!
    
    @IBOutlet weak var appLanguage: UILabel!
    @IBOutlet weak var laguageTXT: UITextField!
    @IBOutlet weak var selectLanguage: UILabel!
    @IBOutlet weak var notificationsSent: UILabel!
    @IBOutlet weak var notifications: UILabel!
    
    var languages:[String] = ["العربيه","english"]
    var selecteddLanguages: [String] = [String]()
    var language = ""
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
		// do someting...
    }
    
    func setUpview()
    {
       main.text = Localization.Application_settings
//        appLanguage.text = Localization.app_language
        selectLanguage.text = Localization.select_language
        alert.text = Localization.alerts
        notificationsSent.text = Localization.send_alert
        selectlan.text = Localization.selectLanguage
        laguageTXT.delegate = self
    }
    
    func getLanguages()
    {
//        image = nil
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: languages) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        print("selected1)")
        menu.setSelectedItems(items: selecteddLanguages) {[weak self] (item, index, isselected, selectedItem) in
            self?.selecteddLanguages = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: Localization.selectLanguage, action: Localization.ok, height: 300.0), from: self)
        menu.onDismiss = { [weak self] items in
            self?.language = (self?.selecteddLanguages[0])!
            self?.laguageTXT.text = self?.language
            if self?.language == "العربيه"{
                self?.image = UIImage(named: "suadiArabia")
                self?.setImage(image: (self?.image)!)
                
            }
            else{
                self?.image = UIImage(named: "skip")
                self?.setImage(image: (self?.image)!)
            }
            
            
        }
    }
    
    func setImage(image: UIImage)
    {
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = image

        laguageTXT.leftView = imageView
        laguageTXT.leftViewMode = UITextField.ViewMode.always
        laguageTXT.leftViewMode = .always
        
    }
}

extension applicationSettingViewController: IapplicationSettingViewController {
	// do someting...
}

extension applicationSettingViewController: UITextFieldDelegate {
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        getLanguages()
    
    return false
    }
    
    
    
    
    
	// do someting...
}

extension applicationSettingViewController {
	// do someting...
}
