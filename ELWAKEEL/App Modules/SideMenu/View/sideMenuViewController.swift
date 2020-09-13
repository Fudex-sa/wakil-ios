//
//  sideMenuViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import MOLH

protocol IsideMenuViewController: class {
	var router: IsideMenuRouter? { get set }
    func assignRequests(requests: sideMenuModel.requests?)

}


class sideMenuViewController: UIViewController {
	var interactor: IsideMenuInteractor?
	var router: IsideMenuRouter?

    
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var createBTN: UIButton!
    @IBOutlet weak var menuTable: UITableView!
    var clinet_name = ""
    let userDefualts = UserDefaults.standard
    var menu_Items: [String] = [Localization.Main, Localization.Record_requests, Localization.Application_settings, Localization.Connect_with_us, Localization.About_the_application, Localization.common_questions, Localization.Share_the_app, Localization.Terms_and_Conditions, Localization.Logout]
    var requests2: sideMenuModel.requests?
    var requ: HomeModel.requests?
    var id = 0
	override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
		// do someting...
        getrequests()

        print("id\(id)")
    }
    func setUpView()
    {
        menuTable.dataSource = self
        menuTable.delegate = self
        let cell = UINib(nibName: "MenuCell", bundle: nil)
        menuTable.register(cell, forCellReuseIdentifier: "menuCell")
        menuTable.rowHeight = 50
        profile.image = UIImage(named: "profile")
        profile.layer.cornerRadius = profile.frame.height/2
        profile.clipsToBounds = true
        createBTN.setTitle(Localization.New_order, for: .normal)
        
        edit.setTitle(Localization.edit, for: .normal)
        clinet_name = userDefualts.string(forKey: "name") ?? ""
        userName.text = clinet_name
        
//        if let url = URL(string: ) {
//            UIImage.loadFrom(url: url) { image in
//                cell.image.image = image
//            }
//        }
//        else{
//            print("no image found")
//        }
        
        
    }
    
    func getrequests()
    {
        interactor?.getRequest()

        
    }
    
    @IBAction func editBTN(_ sender: Any) {
   
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        langauge = MOLHLanguage.currentAppleLanguage()
        
        MOLH.reset()
        
        
        
    }
    @IBAction func createNBT(_ sender: Any) {
        self.navigate(type: .push, module: GeneralRouterRoute.addrequest(params: nil), completion: nil)
    }
    
}

extension sideMenuViewController: IsideMenuViewController {
    
    func assignRequests(requests: sideMenuModel.requests?) {
        self.requests2 = requests
        
    }
    
	// do someting...
}

extension sideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        if indexPath.row == 8 {
            cell.item.textColor = UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00)

        }
        cell.selectionStyle = .none
        cell.item.text = menu_Items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.row {
        case 0:
      self.navigate(type: .root, module: GeneralRouterRoute.Home, completion: nil)   case 1:
          
            self.navigate(type: .push, module: GeneralRouterRoute.requestsRecord, completion: nil)

        case 2:
   self.navigate(type: .push, module: GeneralRouterRoute.applicationSetting, completion: nil)

        case 3:
            
self.navigate(type: .push, module: GeneralRouterRoute.contactUs, completion: nil)
        case 4:
           
            self.navigate(type: .push, module: GeneralRouterRoute.aboutUs, completion: nil)
        case 5:
           
self.navigate(type: .push, module: GeneralRouterRoute.commonQuestios, completion: nil)
        case 6:
            commonFunctions.share.shareApp(viwe: self)
           
        case 7:
            
            self.navigate(type: .push, module: GeneralRouterRoute.terms, completion: nil)
        case 8:
          commonFunctions.share.logout(view: self)
           

        default:
            print("no case selected")
        }
    }
    
    
    
    
    func changeLanguage()
    {
   

         MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension sideMenuViewController {
}
