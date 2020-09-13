//
//  provider_logViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol Iprovider_logViewController: class {
	var router: Iprovider_logRouter? { get set }
    func get_Logs()
    func assign_Logs(logs: provider_logModel.Logs)
}

class provider_logViewController: UIViewController {
	var interactor: Iprovider_logInteractor?
	var router: Iprovider_logRouter?

    @IBOutlet weak var logs_table: UITableView!
    @IBOutlet weak var request_log: UILabel!
    var logs: provider_logModel.Logs?
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        
        setUpView()
        get_Logs()
    }
    
    

    
    func setUpView()
    {
    
        logs_table.delegate = self
        logs_table.dataSource = self
        let nib = UINib(nibName: "provider_log", bundle: nil)
        logs_table.register(nib, forCellReuseIdentifier: "provider_log")
        
        logs_table.layer.cornerRadius = 10
        logs_table.layer.masksToBounds = true
        self.navigationItem.title = Localization.Record_requests
    }
}

extension provider_logViewController: Iprovider_logViewController {
    func get_Logs() {
        interactor?.get_Logs()
    }
    
    func assign_Logs(logs: provider_logModel.Logs) {
        self.logs = logs
        logs_table.reloadData()
    }
    
	// do someting...
}

extension provider_logViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return logs?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "provider_log", for: indexPath) as! provider_log
        if logs?.data[indexPath.row].status?.name == "cancelled"
        {
            cell.request_status.textColor = UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00)

        }
        cell.reuest_num.text =  logs?.data[indexPath.row].request_number
        var address = logs?.data[indexPath.row].country?.name
        address?.append(contentsOf: " - ")
        address?.append(contentsOf: logs?.data[indexPath.row].city?.name ?? "")
        cell.address.text = address
        cell.rquest_DES.text = logs?.data[indexPath.row].description
        cell.request_status.text = logs?.data[indexPath.row].status?.name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let request_id = logs?.data[indexPath.row].id
        {
            router?.request_details(request_id: request_id)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
	// do someting...
}

extension provider_logViewController {
	// do someting...
}
