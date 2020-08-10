//
//  commonFunctions.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import  UIKit
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
        UserDefaults.standard.set(false, forKey: "login")
        UserDefaults.standard.set("", forKey: "token")
        view.navigate(type: .modal, module: GeneralRouterRoute.HomeLogIn, completion: nil)
        //     router?.login()
    }
}
