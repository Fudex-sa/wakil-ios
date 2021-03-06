//
//  commonFunctions.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import  UIKit
import LocalizationFramework
class commonFunctions
{
    public static let share = commonFunctions()
    func shareApp(viwe: UIViewController){
        let textToShare = "share el wakile APP"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = viwe.view
            viwe.present(activityVC, animated: true, completion: nil)
    }
    }
    
    
    func logout(view: UIViewController)
    {
        
        let alert = AlertController(title: " ", message: "", preferredStyle: .actionSheet)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: "", attributes: titleAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")

        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!]
        let messageString = NSAttributedString(string: Localization.logout_DES, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        let sendAction = UIAlertAction(title: Localization.exit, style: .default) { (action) in
            
            UserDefaults.standard.set(false, forKey: "login")
            UserDefaults.standard.set("", forKey: "token")
            view.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
            
        }
        
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        sendAction.setValue(UIColor(red: 0.60, green: 0.25, blue: 0.36, alpha: 1.00), forKey: "titleTextColor")
        
        let cancel = UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil)
        
        alert.setTitleImage(UIImage(named: "notification_image"))
        
        alert.addAction(sendAction)
        alert.addAction(cancel)
        
        
        
       
        
        
        view.present(alert, animated: true, completion: nil)
        
        //     router?.login()
    }
    
    
    
}
