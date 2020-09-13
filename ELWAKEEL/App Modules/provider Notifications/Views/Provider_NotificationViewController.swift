//
//  Provider_NotificationViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import  LocalizationFramework

protocol IProvider_NotificationViewController: class {
	var router: IProvider_NotificationRouter? { get set }
}

class Provider_NotificationViewController: UIViewController {
	var interactor: IProvider_NotificationInteractor?
	var router: IProvider_NotificationRouter?

    @IBOutlet weak var Notification_Table: UITableView!
    var old_Notifications: [String] = ["old","old","old","old","old", "old","old","old"]
    var new_notification: [String] = ["new","new","new", "new","new"]
    var sections: [[String]] = [[String]]()
    let section1_title = Localization.new_Notification
    let section2_title = Localization.old_Notifications
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    func setUpView()
    {   sections = [new_notification, old_Notifications]
        Notification_Table.reloadData()
        Notification_Table.delegate = self
        Notification_Table.dataSource = self
        let nib = UINib(nibName: "provider_Notifications_Cell", bundle: nil)
        Notification_Table.register(nib, forCellReuseIdentifier: "provider_Notifications_Cell")
        self.navigationItem.title = Localization.notifications
    }
    
    
}

extension Provider_NotificationViewController: IProvider_NotificationViewController {
	// do someting...
}

extension Provider_NotificationViewController: UITableViewDelegate, UITableViewDataSource {
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
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "provider_Notifications_Cell", for: indexPath) as! provider_Notifications_Cell
        
        
        cell.Notification_title.text = sections[indexPath.section][indexPath.row]
        
       
        switch indexPath.section{
        case 0:
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 0.01, green: 0.60, blue: 0.58, alpha: 1.00).cgColor
            cell.Notification_Time.textColor = UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00)
            cell.new.isHidden = false
            cell.Notification_Time.text = "12:20:3"
            cell.Notification_title.text = sections[indexPath.section][indexPath.row]
            cell.Notification_Body.text = "نص صغير يوضح ما يحتويه الإشعار لتبليغ المستخدم بما يجب فعله"
        case 1:
            cell.layer.borderColor = nil
            cell.layer.borderWidth = 0
            cell.Notification_Time.textColor = UIColor.black
            cell.new.isHidden = true
            cell.Notification_Time.text = "12:20:3"
            cell.Notification_title.text = sections[indexPath.section][indexPath.row]
            cell.Notification_Body.text = "نص صغير يوضح ما يحتويه الإشعار لتبليغ المستخدم بما يجب فعله"

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

extension Provider_NotificationViewController {
	// do someting...
}
