//
//  Clint_NotificationViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IClint_NotificationViewController: class {
	var router: IClint_NotificationRouter? { get set }
}

class Clint_NotificationViewController: UIViewController {
	var interactor: IClint_NotificationInteractor?
	var router: IClint_NotificationRouter?

    
    @IBOutlet weak var notifications: UILabel!
    @IBOutlet weak var notifications_table: UITableView!
    var old_Notifications: [String] = ["old","old","old","old","old", "old","old","old"]
    var new_notification: [String] = ["new","new","new", "new","new"]
    var sections: [[String]] = [[String]]()
    let section1_title = Localization.new_Notification
    let section2_title = Localization.old_Notifications
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
		// do someting...
    }
    
     func setUpView()
     {
        sections = [new_notification, old_Notifications]
        notifications_table.reloadData()
        notifications.text = Localization.notifications
        notifications_table.dataSource = self
        notifications_table.delegate = self
        let nib = UINib(nibName: "client_notifications_Cell", bundle: nil)
        notifications_table.register(nib, forCellReuseIdentifier: "client_notifications_Cell")
    }
    @IBAction func backBTN(_ sender: Any) {
        dismiss()
    }
    
}

extension Clint_NotificationViewController: IClint_NotificationViewController {
	// do someting...
}

extension Clint_NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return new_notification.count
        case 1:
            return old_Notifications.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "client_notifications_Cell", for: indexPath) as! client_notifications_Cell
        
        
        switch indexPath.section{
        case 0:
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 0.01, green: 0.60, blue: 0.58, alpha: 1.00).cgColor
            cell.notification_time.textColor = UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00)
            cell.new_notification.isHidden = false
            cell.notification_time.text = "12:20:3"
            cell.notification_title.text = sections[indexPath.section][indexPath.row]
            cell.notification_body.text = "نص صغير يوضح ما يحتويه الإشعار لتبليغ المستخدم بما يجب فعله"
        case 1:
            cell.layer.borderColor = nil
            cell.layer.borderWidth = 0
            cell.notification_time.textColor = UIColor.black
            cell.new_notification.isHidden = true
            cell.notification_time.text = "12:20:3"
            cell.notification_title.text = sections[indexPath.section][indexPath.row]
            cell.notification_body.text = "نص صغير يوضح ما يحتويه الإشعار لتبليغ المستخدم بما يجب فعله"
            
        default:
            print("no case seletecc")
        }
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return section1_title + "(\(new_notification.count))"
        case 1:
            return section2_title + "(\(old_Notifications.count))"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        
    }
    
	// do someting...
}

extension Clint_NotificationViewController {
	// do someting...
}
