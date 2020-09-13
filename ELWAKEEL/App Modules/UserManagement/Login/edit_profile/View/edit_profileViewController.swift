//
//  edit_profileViewController.swift
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

protocol Iedit_profileViewController: class {
	var router: Iedit_profileRouter? { get set }
}

class edit_profileViewController: UIViewController {
	var interactor: Iedit_profileInteractor?
	var router: Iedit_profileRouter?

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var image_lbl: UILabel!
    
    @IBOutlet weak var profile_img: UIImageView!
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var cityLBL: UILabel!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var nameBTN: UIButton!
    @IBOutlet weak var phoneBTN: UIButton!
    @IBOutlet weak var addressBTN: UIButton!
    @IBOutlet weak var cityBTN: UIButton!
    @IBOutlet weak var passwordBTN: UIButton!
    let user_defualt = UserDefaults.standard
    @IBOutlet weak var xx: UILabel!
    var image_url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        set_up_View()
        set_up_buttons()
    }
    
    func set_up_View()
    {
        image_lbl.layer.cornerRadius = image_lbl.frame.width / 2
        image_lbl.layer.masksToBounds = true
        image_lbl.text = Localization.change_image
        image_url.append(contentsOf: "http://wakil.dev.fudexsb.com")
       image_url.append(contentsOf: user_defualt.string(forKey: "image")!)
        profile_img.layer.cornerRadius = profile_img.frame.width / 2
        nameLBL.text = Localization.your_name
        phoneLBL.text = Localization.phoneNymber
        addressLBL.text = Localization.address
        cityLBL.text = Localization.city
        passwordLBL.text = Localization.edit_password
       
        
        UIImage.loadFrom(url: URL(string: image_url)!) { (profile_Iamge) in
            self.profile_img.image = profile_Iamge
        }
        
       
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profile_img.isUserInteractionEnabled = true
        profile_img.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("image tapped")
    }

    func set_up_buttons(){
        var name = user_defualt.string(forKey: "name")
        var phone = user_defualt.string(forKey: "phone")
        var adddress = user_defualt.string(forKey: "name")
        var city = user_defualt.string(forKey: "name")
        var password = Localization.password
        name?.append(contentsOf: "  ")
        phone?.append(contentsOf: "  ")
        adddress?.append(contentsOf: "  ")
        city?.append(contentsOf: "  ")
        password.append(contentsOf: "  ")
        name?.append(contentsOf: ">")
        phone?.append(contentsOf: ">")
        adddress?.append(contentsOf: ">")
        city?.append(contentsOf: ">")
        password.append(contentsOf: ">")
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            nameBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            phoneBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            addressBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            cityBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            passwordBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
           

        }
        else  {
            nameBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            phoneBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            addressBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            cityBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            passwordBTN.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        

        }
        nameBTN.setTitle(name, for: .normal)
        phoneBTN.setTitle(phone, for: .normal)
        addressBTN.setTitle(name, for: .normal)
        cityBTN.setTitle(name, for: .normal)
        passwordBTN.setTitle(password, for: .normal)
    }
    
    @IBAction func nameBTN_clicked(_ sender: Any) {
        print("named")
        router?.change_name()
    }
    
    @IBAction func phoneBTN_clicked(_ sender: Any) {
        print("named5")
        router?.change_phone()

    }
    
    
    @IBAction func addressBTN_Clicked(_ sender: Any) {
        print("named2")
        router?.change_address()

    }
    
    @IBAction func cityBTN_Clicked(_ sender: Any) {
        print("named3")
        router?.change_city()

    }
    
    @IBAction func password_clicked(_ sender: Any) {
        print("named4")
        router?.change_password()

    }
}

extension edit_profileViewController: Iedit_profileViewController {
	// do someting...
}

extension edit_profileViewController {
	// do someting...
}

extension edit_profileViewController {
	// do someting...
}
