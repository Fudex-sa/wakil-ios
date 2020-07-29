//
//  editRequestViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IeditRequestViewController: class {
	var router: IeditRequestRouter? { get set }
}

class editRequestViewController: UIViewController {
	var interactor: IeditRequestInteractor?
	var router: IeditRequestRouter?

    
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderDES: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var region1: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var city1: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var minstry: UILabel!
    @IBOutlet weak var minstry1: UILabel!
    @IBOutlet weak var achieve: UILabel!
    @IBOutlet weak var achieve1: UILabel!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView(){
        
        edit.layer.cornerRadius = 10
        cancel.layer.cornerRadius = 10
        orderNum.text = Localization.Order_number
        orderDES.text = Localization.request_DES
        orderStatus.text = Localization.Under_processing
        region.text = Localization.Region
        city.text = Localization.city
        address.text = Localization.Authority_address
        minstry.text = Localization.minstryAndAuth
        achieve.text = Localization.achievement
        textView.delegate = self
        edit.setTitle(Localization.edit, for: .normal)
        cancel.setTitle(Localization.cancel, for: .normal)
        
    }
    
    @IBAction func editBTN(_ sender: Any) {
        self.navigate(type: .modal, module: GeneralRouterRoute.addrequest, completion: nil)
    }
    
    @IBAction func cancelBTN(_ sender: Any) {
        let alert = UIAlertController(title: Localization.cancel_request, message: Localization.cancel_reason, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil)
        let sendAction = UIAlertAction(title: Localization.sendBTN, style: .default) { (action) in
            print("send")
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
        
    }
    
    @IBAction func backBTN(_ sender: Any) {
        dismiss()
    }
    
}

extension editRequestViewController: IeditRequestViewController {
	// do someting...
}

extension editRequestViewController {
	// do someting...
}

extension editRequestViewController: UITextViewDelegate {
	// do someting...
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < 360
    }
}
