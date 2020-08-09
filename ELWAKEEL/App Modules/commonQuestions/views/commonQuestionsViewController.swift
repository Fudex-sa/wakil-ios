//
//  commonQuestionsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcommonQuestionsViewController: class {
	var router: IcommonQuestionsRouter? { get set }
}

class commonQuestionsViewController: UIViewController {
	var interactor: IcommonQuestionsInteractor?
	var router: IcommonQuestionsRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension commonQuestionsViewController: IcommonQuestionsViewController {
	// do someting...
}

extension commonQuestionsViewController {
	// do someting...
}

extension commonQuestionsViewController {
	// do someting...
}
