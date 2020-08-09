//
//  HomeProviderViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IHomeProviderViewController: class {
	var router: IHomeProviderRouter? { get set }
}

class HomeProviderViewController: UIViewController {
	var interactor: IHomeProviderInteractor?
	var router: IHomeProviderRouter?

    @IBOutlet weak var acceptTable: UITableView!
    @IBOutlet weak var Notifications: UILabel!
    @IBOutlet weak var Home: UILabel!
    @IBOutlet weak var requestsTable: UITableView!
    @IBOutlet weak var requestNum: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var servicesRequests: UILabel!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        servicesRequests.text = Localization.Service_requests
        Home.text = Localization.Main
        topView.layer.cornerRadius = 8
        bottomView.layer.cornerRadius = 8
        let uib = UINib(nibName: "acceptCell", bundle: nil)
        acceptTable.register(uib, forCellReuseIdentifier: "acceptCell")
        let uib2 = UINib(nibName: "RequestsCell", bundle: nil)
        requestsTable.register(uib2, forCellReuseIdentifier: "RequestsCell")
      Notifications.layer.cornerRadius = Notifications.frame.width / 2
        Notifications.layer.masksToBounds = true
        acceptTable.delegate = self
        acceptTable.dataSource = self
        requestsTable.delegate = self
        requestsTable.dataSource = self
    }
    
    @IBAction func seeALl(_ sender: Any) {
    }
    
    
}

extension HomeProviderViewController: IHomeProviderViewController {
	// do someting...
}

extension HomeProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == acceptTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "acceptCell", for: indexPath) as! acceptCell
            cell.delegate = self
            cell.address.text = "minia"
            cell.delivery.text = "done"
            cell.requestNum.text = "20"
            return cell

        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsCell", for: indexPath) as! RequestsCell
            cell.des.text = "des"
            cell.requestStatus.text = "accept"
            cell.reuestNum2.text = "20"
            cell.address.text = "samalout"
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == acceptTable{
            return 235
        }
        else{
            return 150
        }
    }
    
	// do someting...
}

extension HomeProviderViewController: buttons{
    func cancel() {
        print("cancelled")
    }
    
    func accept() {
        print("accepted")
    }
    
	// do someting...
}
