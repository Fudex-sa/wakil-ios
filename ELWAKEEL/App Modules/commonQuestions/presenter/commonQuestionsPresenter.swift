//
//  commonQuestionsPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcommonQuestionsPresenter: class {
	// do someting...
    func assignQuestions(questions: Data)
}

class commonQuestionsPresenter: IcommonQuestionsPresenter {
    func assignQuestions(questions: Data) {
        view?.assignQuestion(questions: questions)
    }
    
	weak var view: IcommonQuestionsViewController?
	
	init(view: IcommonQuestionsViewController?) {
		self.view = view
	}
}
