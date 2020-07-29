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

protocol IsideMenuViewController: class {
	var router: IsideMenuRouter? { get set }
}
enum MenuType: Int {
    case home
    case camera
    case profile
}

class sideMenuViewController: UIViewController {
	var interactor: IsideMenuInteractor?
	var router: IsideMenuRouter?

    
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var createBTN: UIButton!
    @IBOutlet weak var menuTable: UITableView!
    var didTapMenuType: ((MenuType) -> Void)?
    var menu_Items: [String] = [Localization.Main, Localization.Record_requests, Localization.Application_settings, Localization.Connect_with_us, Localization.About_the_application, Localization.common_questions, Localization.Share_the_app, Localization.Terms_and_Conditions, Localization.Logout]
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
		// do someting...
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
    
    @IBAction func editBTN(_ sender: Any) {
    }
    
    @IBAction func createNBT(_ sender: Any) {
    }
    
}

extension sideMenuViewController: IsideMenuViewController {
	// do someting...
}

extension sideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.item.text = menu_Items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
    
    
	// do someting...
}

extension sideMenuViewController {
	// do someting...
}
