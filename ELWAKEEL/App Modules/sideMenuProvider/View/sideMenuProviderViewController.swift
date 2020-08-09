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
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        
        sideTable.delegate = self
        sideTable.dataSource = self
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        edit.titleLabel?.text = Localization.edit
        let Uinib = UINib(nibName: "sideMenuCell", bundle: nil)
        sideTable.register(Uinib, forCellReuseIdentifier: "sideMenuCell")
        
    }
    
    
    @IBAction func edit(_ sender: Any) {
    }
    
}

extension sideMenuProviderViewController: IsideMenuProviderViewController {
	// do someting...
}

extension sideMenuProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! sideMenuCell
        cell.cellTitle.text = "a&A"
        cell.cellTitle.font =  UIFont(name: "CoconÆ Next Arabic", size: 18)
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
	// do someting...
}

extension sideMenuProviderViewController {
	// do someting...
}
