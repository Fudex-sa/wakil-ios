//
//  requestrecordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestrecordPresenter: class {
	// do someting...
    func assignRecords(records: requestrecordModel.recods)
}

class requestrecordPresenter: IrequestrecordPresenter {
    func assignRecords(records: requestrecordModel.recods) {
        view?.assignrecords(records: records)
    }
    
	weak var view: IrequestrecordViewController?
	
	init(view: IrequestrecordViewController?) {
		self.view = view
	}
}
