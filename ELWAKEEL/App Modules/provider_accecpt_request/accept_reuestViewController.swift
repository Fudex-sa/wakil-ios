//
//  accept_reuestViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol Iaccept_reuestViewController: class {
	var router: Iaccept_reuestRouter? { get set }
    func craete_offer(price: Double, required_paper: String, duration: String, service_id: Int)
    func go_home()
}

class accept_reuestViewController: UIViewController {
	var interactor: Iaccept_reuestInteractor?
	var router: Iaccept_reuestRouter?
    
    
    @IBOutlet weak var accept_reuest: UILabel!
    @IBOutlet weak var near_reuests: UILabel!
    @IBOutlet weak var near_request_DES: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceTXT: UITextField!
    @IBOutlet weak var required_paper: UILabel!
    @IBOutlet weak var required_paperTXT: UITextField!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timeTXT: UITextField!
    @IBOutlet weak var sentBTN: GradientButton!
    @IBOutlet weak var cost_prics: UILabel!
    var request_id: Int?
    var cost: Double?
    var params: [String: Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        delegates()
        hideKeyboardWhenTappedAround()
    }
    func setUpView()
    {
        
        near_reuests.text = Localization.near_requests
        near_request_DES.text = Localization.request_accept_DES
        price.text = Localization.price_show
        cost_prics.text = Localization.cost_show
        required_paper.text = Localization.required_paper
        time.text = Localization.excutions_time
        sentBTN.setTitle(Localization.send, for: .normal)
         self.navigationItem.title = Localization.request_accept

        
    }
    func delegates()
    {
        priceTXT.delegate = self
        required_paperTXT.delegate = self
        timeTXT.delegate = self
        
    }
    
    func validate_data()
    {
        guard let price = priceTXT.text, !price.isEmpty else{
            
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.required_price_field, sender: self)
            priceTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        
        guard let required_papers = required_paperTXT.text, !required_papers.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.requied_papers_feilds, sender: self)
            required_paperTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        guard let time = timeTXT.text, !time.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.requierd_time_field, sender: self)
            timeTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        
        guard let cost =  Double(price) else {
            
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.vaild_value, sender: self)
            priceTXT.attributedPlaceholder =  NSAttributedString(string:Localization.vaild_value, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            return
        }
       
        if let id = request_id{
            craete_offer(price: cost, required_paper: required_papers, duration: time, service_id: id)
        }
    }
    
    @IBAction func sendBTN(_ sender: Any) {
        validate_data()
    }
    
    
    
}

extension accept_reuestViewController: Iaccept_reuestViewController {
    func go_home() {
        
        let alert = AlertController(title: " ", message: Localization.offer_added, preferredStyle: .alert)
        
        let sendAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
            self.router?.go_home()
            
        }
       
        alert.addAction(sendAction)
        present(alert, animated: true, completion: nil)
        
        }
    
    
   
    
    func craete_offer(price: Double, required_paper: String, duration: String, service_id: Int) {
        interactor?.craete_offer(price: price, required_paper: required_paper, duration: duration, service_id: service_id)
        
    }
}

extension accept_reuestViewController: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        // do someting...
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
	// do someting...
}

extension accept_reuestViewController {
	// do someting...
}
