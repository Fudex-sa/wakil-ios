//
//  commonQuestionsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcommonQuestionsInteractor: class {
	var parameters: [String: Any]? { get set }
    func getQuestion()
}

class commonQuestionsInteractor: IcommonQuestionsInteractor {
    func getQuestion() {
        worker?.getquestion(complition: { (success, error, response) in
            if success{
                self.presenter?.assignQuestions(questions: response ?? Data())
            }
            else{
                print("error\(error?.message)")
            }
        })
    }
    
    var presenter: IcommonQuestionsPresenter?
    var worker: IcommonQuestionsWorker?
    var parameters: [String: Any]?

    init(presenter: IcommonQuestionsPresenter, worker: IcommonQuestionsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
