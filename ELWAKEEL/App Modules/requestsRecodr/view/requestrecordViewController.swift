//
//  requestrecordViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IrequestrecordViewController: class {
	var router: IrequestrecordRouter? { get set }
    func assignrecords(records: requestrecordModel.recods)
}

class requestrecordViewController: UIViewController {
	var interactor: IrequestrecordInteractor?
	var router: IrequestrecordRouter?

    @IBOutlet weak var recordsTable: UITableView!
    @IBOutlet weak var Home: UILabel!
    var records: requestrecordModel.recods?
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    
     func setUpView()
     {
        Home.text = Localization.Main
        let unib = UINib(nibName: "recordRequests", bundle: nil)
        recordsTable.register(unib, forCellReuseIdentifier: "recordRequests")
        recordsTable.delegate = self
        recordsTable.dataSource = self
        interactor?.getrecords()
//        let userDefaults = UserDefaults.standard
//        let id = userDefaults.string(forKey: "id")
//    let token = userDefaults.string(forKey: "token")
//        
    }
    
    
    @IBAction func show_side_menu(_ sender: Any) {
        router?.show_side_menu()
    }
    
    
}

extension requestrecordViewController: IrequestrecordViewController {
    func assignrecords(records: requestrecordModel.recods) {
           self.records = records
        recordsTable.reloadData()
    }
    
	// do someting...
}

extension requestrecordViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordRequests", for: indexPath) as! recordRequests
        cell.des.text = records?.data[indexPath.row].description
        cell.requetNum1.text = Localization.requestNum
        if let id = records?.data[indexPath.row].id{
            cell.requesrNum2.text = String(describing: id)

        }
         var  address = records?.data[indexPath.row].country?.name
        address?.append(contentsOf: " - ")
        address?.append(contentsOf: (records?.data[indexPath.row].city?.name)!)
        cell.address.text = address
        cell.requeststatus.text = records?.data[indexPath.row].status?.name
        cell.selectionStyle = .none
        return cell
    }
    
	// do someting...
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

extension requestrecordViewController {
	// do someting...
}
