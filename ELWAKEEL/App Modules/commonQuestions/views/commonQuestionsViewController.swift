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
import LocalizationFramework

protocol IcommonQuestionsViewController: class {
	var router: IcommonQuestionsRouter? { get set }
    func assignQuestion(questions: Data)
}

class commonQuestionsViewController: UIViewController {
	var interactor: IcommonQuestionsInteractor?
	var router: IcommonQuestionsRouter?

    
    @IBOutlet weak var FQAtable: UITableView!
    @IBOutlet weak var FQA: UILabel!
    @IBOutlet weak var sidemenu: UILabel!
    var Questions: Data?
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...]
        setUpView()
        getquestion()
    }
    
    func setUpView()
    {
       FQAtable.delegate = self
        FQAtable.dataSource = self
        let nib = UINib(nibName: "FQAcell", bundle: nil)
        FQAtable.register(nib, forCellReuseIdentifier: "FQAcell")
        FQA.text = Localization.FQA
    }
    func getquestion()
    {
        interactor?.getQuestion()
        
    }
    
    @IBAction func sideMenu(_ sender: Any) {
    }
    
}

extension commonQuestionsViewController: IcommonQuestionsViewController {
    func assignQuestion(questions: Data) {
        self.Questions = questions
    }
    
	// do someting...
}

extension commonQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FQAcell", for: indexPath) as! FQAcell
        cell.question.text = "Question?"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
	// do someting...
}

extension commonQuestionsViewController {
	// do someting...
}
