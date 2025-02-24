//
//  NotificationPermission.swift
//  Shahen
//
//  Created by rh.com.sa on 25/08/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

/**
 Permission Protocol to confirm
 
 - warning: if you want any class to need access permission must implement this protocol
 
 */
protocol Permission: SPPermissionsDelegate {
    /**
     Authorize of list of permissions
     
     - parameter permissions: list of SPPermissions.
     - returns: Bool type
     - warning: don't care
     
     */
    func authroize(_ permissions: SPPermissions.Permission...) -> Bool
    /**
     Access the list of permissions
     
     - parameter permissions: list of SPPermissions.
     - returns: Void
     - warning: you need to confirm the reload function !!
     
     */
    func access(_ permissions: SPPermissions.Permission...)
    /**
     relaod function call it after hide the access of permissions
     
     - parameter none: Void.
     - returns: Void
     - warning: must implement it to know you get access or not
     
     */
    func reload()
}


extension Permission {
    /**
     Authorize of list of permissions
     
     - parameter permissions: list of SPPermissions.
     - returns: Bool type
     - warning: don't care
     
     */
    func authroize(_ permissions: SPPermissions.Permission...) -> Bool {
        var auth = true
        for permission in permissions {
            let status = permission.authorized
            if !status {
                auth = false
            }
        }
        return auth
    }
    /**
     Access the list of permissions
     
     - parameter permissions: list of SPPermissions.
     - returns: Void
     - warning: you need to confirm the reload function !!
     
     */
    func access(_ permissions: SPPermissions.Permission...) {
        let permissions: [SPPermissions.Permission] = permissions
        // 2a. List Style
        let controller = SPPermissions.dialog(permissions)
        controller.dismissCondition = .allPermissionsDeterminated
        controller.delegate = self
        //controller.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let scene = UIApplication.topViewController() else { return }
            controller.present(on: scene)
        }
    }
    
    /**
     didHidePermissions of SP to know the access is hidden
     
     - parameter permissions: [SPPermissions.Permission].
     - returns: void
     - warning: none
     
     */
    func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        reload()
    }
}
