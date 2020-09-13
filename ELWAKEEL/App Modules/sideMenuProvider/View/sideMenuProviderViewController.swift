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
    let home_provider = HomeProviderViewController()
    
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
            self.navigate(type: .root, module: GeneralRouterRoute.HomeProvider, completion: nil)
        case 1:
           self.navigate(type: .push, module: GeneralRouterRoute.wallet, completion: nil)
        case 2:
             self.navigate(type: .push, module: GeneralRouterRoute.provider_log, completion: nil)

        case 3:
             self.navigate(type: .push, module: GeneralRouterRoute.applicationSetting, completion: nil)
            print("setting")
            //            self.router?.application_Setting()
            
        case 4:
             self.navigate(type: .push, module: GeneralRouterRoute.contactUs, completion: nil)
            print("connect with us")
            
        case 5:
      self.navigate(type: .push, module: GeneralRouterRoute.aboutUs, completion: nil)
      print("about the applicatin")
            
        case 6:
        self.navigate(type: .push, module: GeneralRouterRoute.commonQuestios, completion: nil)
        print("commom questio")
            
        case 7:
            print("share app")
            commonFunctions.share.shareApp(viwe: self)
        case 8:
            print("terms")
             self.navigate(type: .push, module: GeneralRouterRoute.terms, completion: nil)
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
