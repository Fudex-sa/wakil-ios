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
        userName.text = "احمد زجب خلف الله"
        edit.setTitle(Localization.edit, for: .normal)
        
        
    }
    
    func getrequests()
    {
        print("request Called")
        interactor?.getRequest()
        print("request Called")

        
    }
    
    @IBAction func editBTN(_ sender: Any) {
    }
    
    @IBAction func createNBT(_ sender: Any) {
        self.navigate(type: .modal, module: GeneralRouterRoute.addrequest, completion: nil)
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
        cell.selectionStyle = .none
        cell.item.text = menu_Items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.row {
        case 0:
            self.router?.main()
            
        case 1:
            print("recode_ request")
            self.router?.record_requests()

        case 2:
            print("setting")
            changeLanguage()
//            self.router?.application_Setting()

        case 3:
            print("connect with us")
            self.router?.connect_with_us()

        case 4:
            print("about the applicatin")
            self.router?.about_the_application()

        case 5:
            print("commom questio")
            self.router?.common_question()

        case 6:
            print("share app")
            self.router?.share_the_app()
        case 7:
            print("terms")
            self.router?.terms_and_conditions()
        case 8:
            print("logOut")
            logout()

        default:
            print("no case selected")
        }
    }
    
    func logout()
    {
        UserDefaults.standard.set(false, forKey: "login")
        UserDefaults.standard.set("", forKey: "token")
        self.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
//     router?.login()
    }
    func changeLanguage()
    {
   
//       if Locale.current.languageCode == "en"
//       {
//        Locale.current.l = "ar"
//        }
//       else{
//        Locale.current.languageCode = "en"
//        }
         MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension sideMenuViewController {
}
