//
//  termsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
protocol ItermsViewController: class {
	var router: ItermsRouter? { get set }
    func assignTerms(trems: termsModel.Terms)
}

class termsViewController: UIViewController {
	var interactor: ItermsInteractor?
	var router: ItermsRouter?

    @IBOutlet weak var termsTbale: UITableView!
    @IBOutlet weak var terms: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var wakile: UILabel!
    var terms_modle: termsModel.Terms?
    let user_default = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getterms()
        set_up_navigation()
    }
    func setUpView()
    {
        
        language.text = Localization.language
        termsTbale.delegate = self
        termsTbale.dataSource = self
        let nib = UINib(nibName: "termsCell", bundle: nil)
        termsTbale.register(nib, forCellReuseIdentifier: "termsCell")
        wakile.text = "wakel-hkome@2019"
        self.navigationItem.title = Localization.Terms_and_Conditions
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
    func getterms()
    {
       interactor?.get_terms()
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        router?.show_side_menu()
    }
    
}

extension termsViewController: ItermsViewController {
    func assignTerms(trems: termsModel.Terms) {
        self.terms_modle = trems
        termsTbale.reloadData()
    }
    
	// do someting...
}

extension termsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "termsCell", for: indexPath) as!termsCell
        
        cell.title.text = terms_modle?.title
        cell.content.text = terms_modle?.content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
    }
	// do someting...
}

extension termsViewController {
	// do someting...
}
