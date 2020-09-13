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
import MOLH

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
    
    @IBOutlet weak var lang_view: UIView!
    
    @IBOutlet weak var lang: UIButton!
    
    
    var languages:[String] = ["العربيه","english"]
    var selecteddLanguages: [String] = [String]()
    var language = ""
    var image: UIImage?
    let user_default = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        set_image_lang()
        set_up_navigation()
        // do someting...
    }
    
    func setUpview()
    {
        
        lang_view.layer.borderWidth = 1.0
        
        lang_view.layer.borderColor = UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 1.00).cgColor
        laguageTXT.borderStyle = .none
          selectLanguage.text = Localization.select_language
        alert.text = Localization.alerts
        notificationsSent.text = Localization.send_alert
        selectlan.text = Localization.selectLanguage
        laguageTXT.delegate = self
        
    }
    func set_up_navigation()
    {          self.navigationItem.title = Localization.Application_settings
        if user_default.string(forKey: "type") == "provider" {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)

            
        }
        else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)

        }
        
    }
    
    func set_image_lang(){
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            lang.setImage(UIImage(named: "suadiArabia"), for: .normal)
        }
        else{
            lang.setImage(UIImage(named: "america"), for: .normal)
        }
    }
    
    func getLanguages()
    {
        //        image = nil
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: languages) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selecteddLanguages) {[weak self] (item, index, isselected, selectedItem) in
            self?.selecteddLanguages = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: Localization.selectLanguage, action: Localization.ok, height: 300.0), from: self)
        menu.onDismiss = { [weak self] items in
            self?.language = (self?.selecteddLanguages[0])!
            self?.laguageTXT.text = self?.language
            
            if self?.language == "العربيه"{
                
                self?.lang.setImage(UIImage(named: "suadiArabia"), for: .normal)
                
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
                langauge = MOLHLanguage.currentAppleLanguage()
                UserDefaults.standard.set("en", forKey: "language")
                MOLH.reset()
                self?.image = UIImage(named: "suadiArabia")
                
            }
            else{
                self?.lang.setImage(UIImage(named: "america"), for: .normal)
                
                MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
                langauge = MOLHLanguage.currentAppleLanguage()
                UserDefaults.standard.set("ar", forKey: "language")
                MOLH.reset()
                
            }
            
            
        }
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
