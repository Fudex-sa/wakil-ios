//
//  aboutUsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import RSSelectionMenu
import LocalizationFramework

protocol IaboutUsViewController: class {
	var router: IaboutUsRouter? { get set }
    func assignContact_info(contact_Info: aboutUsModel.About)
}

class aboutUsViewController: UIViewController {
	var interactor: IaboutUsInteractor?
	var router: IaboutUsRouter?
    var selectedItems: [String] = [String]()
    
    @IBOutlet weak var aboutApp: UILabel!
    @IBOutlet weak var sideMenu: UIButton!
     @IBOutlet weak var about: UILabel!
    @IBOutlet weak var contactUs: UILabel!
    @IBOutlet weak var callIMG: UIImageView!
    @IBOutlet weak var tiwtterImg: UIImageView!
    @IBOutlet weak var tiwitter: UILabel!
    @IBOutlet weak var faceBookImg: UIImageView!
    @IBOutlet weak var facebook: UILabel!
    @IBOutlet weak var gmailImg: UIImageView!
    @IBOutlet weak var gmail: UILabel!
    @IBOutlet weak var call: UILabel!
    
    var twitterTap: UITapGestureRecognizer = UITapGestureRecognizer()
    var whatsappTap: UITapGestureRecognizer = UITapGestureRecognizer()
    var gmailTap: UITapGestureRecognizer = UITapGestureRecognizer()
    var facebooktap: UITapGestureRecognizer = UITapGestureRecognizer()
    var contact_info: aboutUsModel.About?
    let user_default = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        getContact_info()
        set_up_navigation()
        
    }
    func set_up_navigation()
    {
        self.navigationItem.title = Localization.About_the_application
           if user_default.string(forKey: "type") == "provider" {
               self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)

               
           }
           else {
               self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)

           }
           
       }
    func setUpView()
    {
        about.text = Localization.app_Des
        contactUs.text = Localization.Contact_information

        facebooktap = UITapGestureRecognizer(target: self, action: #selector(self.facebook_Tapped))
        whatsappTap = UITapGestureRecognizer(target: self, action: #selector(self.whatsapp_Tapped))
        twitterTap = UITapGestureRecognizer(target: self, action: #selector(self.twitter_Tapped))
        gmailTap = UITapGestureRecognizer(target: self, action: #selector(self.gmail_Tapped))
        facebook.addGestureRecognizer(facebooktap)
        call.addGestureRecognizer(whatsappTap)
        tiwitter.addGestureRecognizer(twitterTap)
        gmail.addGestureRecognizer(gmailTap)
        
        
    }
    @objc func facebook_Tapped()
    {
        guard let url = URL(string: facebook.text!) else {
            return
        }
        
        openUrl(url: url)
      
    }
    @objc func gmail_Tapped()
    {
        guard let url = URL(string: gmail.text!) else {
            return
        }
        
        openUrl(url: url)
       
    }
    @objc func whatsapp_Tapped()
    {
        
        guard let number = URL(string: "tel://" + call.text!) else { return }
        UIApplication.shared.open(number)

       

    }
    @objc func twitter_Tapped()
    {
        guard let url = URL(string: tiwitter.text!) else {
            return
        }
        
        openUrl(url: url)
       
    }
    
    func openUrl(url: URL)
   {
    
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        print("facebook tapped")
    }
    
   func getContact_info()
   {
    interactor?.get_contact_info()
    }
    
    @IBAction func sideMenu(_ sender: Any) {
       router?.show_side_menu()
        
    }
    
    
   
    
    
}

extension aboutUsViewController: IaboutUsViewController {
    func assignContact_info(contact_Info: aboutUsModel.About) {
        
        self.contact_info = contact_Info
       DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                self.call.text = contact_Info.contacts[1].value
                self.tiwitter.text = contact_Info.contacts[3].value
                self.gmail.text = contact_Info.contacts[4].value
                self.facebook.text = contact_Info.contacts[2].value
                
            }
        }
        
    }
    
    
	// do someting...
}

extension aboutUsViewController {
	// do someting...
}

extension aboutUsViewController {
	// do someting...
}
