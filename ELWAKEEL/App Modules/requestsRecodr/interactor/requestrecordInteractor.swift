//
//  requestrecordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestrecordInteractor: class {
	var parameters: [String: Any]? { get set }
    func getrecords()
}

class requestrecordInteractor: IrequestrecordInteractor {
    func getrecords() {
        worker?.getrecords(complition: { (success, error, records) in
            
            if success{
                if records != nil
                {
                    
                    self.presenter?.assignRecords(records: records!)
                }
                else
                {
                    print("records is equal nil")
                }
            }
            else{
                print("error\(error?.message)")
            }
        })
    }
    
   
    var presenter: IrequestrecordPresenter?
    var worker: IrequestrecordWorker?
    var parameters: [String: Any]?

    init(presenter: IrequestrecordPresenter, worker: IrequestrecordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
