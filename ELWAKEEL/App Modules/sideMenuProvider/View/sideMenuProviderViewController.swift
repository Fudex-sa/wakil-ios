//
//  sideMenuProviderViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IsideMenuProviderViewController: class {
	var router: IsideMenuProviderRouter? { get set }
}

class sideMenuProviderViewController: UIViewController {
	var interactor: IsideMenuProviderInteractor?
	var router: IsideMenuProviderRouter?

    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var sideTable: UITableView!
    var provider_name = ""
    let userDefualts = UserDefaults.standard
    var menu_Items: [String] = [Localization.Main, Localization.wallet, Localization.Record_requests, Localization.Application_settings, Localization.Connect_with_us, Localization.About_the_application, Localization.common_questions, Localization.Share_the_app, Localization.Terms_and_Conditions, Localization.Logout]
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        provider_name = userDefualts.string(forKey: "name") ?? ""
        sideTable.delegate = self
        sideTable.dataSource = self
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        let Uinib = UINib(nibName: "sideMenuCell", bundle: nil)
        sideTable.register(Uinib, forCellReuseIdentifier: "sideMenuCell")
        edit.setTitle(Localization.edit, for: .normal)
        name.text = provider_name
        
    }
    
    
    @IBAction func edit(_ sender: Any) {
    }
    
}

extension sideMenuProviderViewController: IsideMenuProviderViewController {
	// do someting...
}

extension sideMenuProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! sideMenuCell
        if indexPath.row == 9 {
        cell.cellTitle.textColor = UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00)
            
        }
        cell.selectionStyle = .none
        cell.cellTitle.text = menu_Items[indexPath.row]
        cell.cellTitle.font =  UIFont(name: "CoconÆ Next Arabic", size: 18)
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            router?.GO_home()
        case 1:
            router?.GO_wallet()
            print("recode_ request")
        case 2:
            router?.Records()

        case 3:
            router?.App_setting()
            print("setting")
            //            self.router?.application_Setting()
            
        case 4:
            router?.Go_contact_us()
            print("connect with us")
            
        case 5:
            router?.About_app()
            print("about the applicatin")
            
        case 6:
            router?.FQA()
            print("commom questio")
            
        case 7:
            print("share app")
            commonFunctions.share.shareApp(viwe: self)
        case 8:
            print("terms")
            router?.GO_terms()
        case 9:
            print("logOut")
            commonFunctions.share.logout(view: self)
            
        default:
            print("no case selected")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
	// do someting...
}

extension sideMenuProviderViewController {
	// do someting...
}
