//
//  ChatPresenter.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IChatPresenter: class {
    func assing_messages(message: ChatModel.data)
    func get_messages()
    func admin_join()


	// do someting...
}

class ChatPresenter: IChatPresenter {
    func admin_join() {
        view?.admin_join()
    }
    
    func get_messages() {
        view?.get_messages()
    }
    
    func assing_messages(message: ChatModel.data) {
        view?.assing_messages(message: message)
    }
    
	weak var view: IChatViewController?
	
	init(view: IChatViewController?) {
		self.view = view
	}
}
