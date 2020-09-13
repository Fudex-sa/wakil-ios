//
//  Clint_NotificationPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IClint_NotificationPresenter: class {
	// do someting...
    func assign_notification(notifications: Clint_NotificationModel.Notification)

}

class Clint_NotificationPresenter: IClint_NotificationPresenter {
    func assign_notification(notifications: Clint_NotificationModel.Notification) {
        view?.assign_notification(notifications: notifications)
    }
    
	weak var view: IClint_NotificationViewController?
	
	init(view: IClint_NotificationViewController?) {
		self.view = view
	}
    
    
}
