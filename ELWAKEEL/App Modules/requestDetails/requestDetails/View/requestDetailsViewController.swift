//
//  requestDetailsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import  LocalizationFramework

protocol IrequestDetailsViewController: class {
	var router: IrequestDetailsRouter? { get set }
    func cancelRequest(id: Int, reason: String)
    func cancle()
    func get_request_details(request_id: Int)
    func assign_request_details(request: requestDetailsModel.RequestDetails?)

}

class requestDetailsViewController: UIViewController {
	var interactor: IrequestDetailsInteractor?
	var router: IrequestDetailsRouter?

    
    @IBOutlet weak var reqDEtails: UILabel!
    @IBOutlet weak var requestNum: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var RequestDES: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var region1: UILabel!
    @IBOutlet weak var region2: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var city1: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var minstry1: UILabel!
    @IBOutlet weak var minstry2: UILabel!
    @IBOutlet weak var achieve1: UILabel!
    @IBOutlet weak var achieve2: UILabel!
    @IBOutlet weak var providerIMG: UIImageView!
    @IBOutlet weak var workPeriod: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var serviceprovidername: UILabel!
    @IBOutlet weak var serviceProviderName1: UILabel!
    @IBOutlet weak var chat: UILabel!
    @IBOutlet weak var recitp: UIButton!
    @IBOutlet weak var canel: UIButton!
    @IBOutlet weak var required_papers1: UILabel!
    @IBOutlet weak var titleTXT: UITextField!
    @IBOutlet weak var requiref_paper2: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    
    
    var reason = ""
    var id: Int?
    var request_details: requestDetailsModel.RequestDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    
        
        setUpView()
    }
    
    func setUpView()
    {
        providerIMG.layer.cornerRadius = providerIMG.frame.width/2
        providerIMG.layer.masksToBounds = true
        reqDEtails.text = Localization.Order_details
        requestNum.text = Localization.Order_number
        requestStatus.text = Localization.Under_processing
        RequestDES.text = Localization.request_DES
        region1.text = Localization.Region
        city.text = Localization.city
        address1.text = Localization.Authority_address
        minstry1.text = Localization.minstryAndAuth
        chat.text = Localization.conversation
        achieve1.text = Localization.achievement
        workPeriod.text = Localization.period_of_work
        hour.text = Localization.Hours
        price.text = Localization.price
        currency.text = Localization.SR
        titleLBL.text = Localization.title_name
        serviceprovidername.text = Localization.serviceSupplierName
        required_papers1.text = Localization.required_paper
        recitp.setTitle(Localization.Receipt, for:.normal)
        canel.setTitle(Localization.cancel, for: .normal)
        
        if let id = id{
            get_request_details(request_id: id)
        }
    }
    
    @IBAction func chatBTN(_ sender: Any) {
        
        
    }
    
    
    @IBAction func back(_ sender: Any) {
    
    dismiss()
    }
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        let alert = UIAlertController(title: Localization.cancelRequest, message: Localization.cancelReason, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
            self.reason = (alert.textFields?[0].text)!
            self.cancelRequest(id: self.id!, reason: self.reason)
        }
        
        
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .default) { (action) in
            print("canel")
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
    }
    @IBAction func recive(_ sender: Any) {
        
    }
    
    
    @IBAction func cancelRequest(_ sender: Any) {
        let alert = UIAlertController(title: Localization.cancelRequest, message: Localization.cancelReason, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
            self.reason = (alert.textFields?[0].text)!
            self.cancelRequest(id: self.id!, reason: self.reason)
        }
        
        
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .default) { (action) in
            print("canel")
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
    }
    
    func configueUI()
    {
        requestNum.text =  request_details?.request_number
        requestStatus.text = request_details?.status?.name
        textView.text = request_details?.description
        region2.text = request_details?.country.name
        city1.text = request_details?.city.name
        address2.text = request_details?.address
        minstry2.text = request_details?.organization.name
        achieve2.text = request_details?.achievement_proof
        serviceProviderName1.text = request_details?.offer?.provider.name
        requiref_paper2.text = request_details?.offer?.required_paper
        hour.text = request_details?.progress_time
        titleTXT.text = request_details?.title
        if let price = request_details?.offer?.price_after_tax{
            currency.text = String(describing: price) + " " + Localization.SR
            
        }
     
        
    }
    
}

extension requestDetailsViewController: IrequestDetailsViewController {
    func assign_request_details(request: requestDetailsModel.RequestDetails?) {
        if let request = request {
            self.request_details = request
            configueUI()
        }
    }
    
    func get_request_details(request_id: Int) {
        if id != nil{
            interactor?.get_request_details(request_id: id!)
        }
        
    }
    
    
    
    func cancelRequest(id: Int, reason: String) {
            self.interactor?.cancelRequest(id: id, reason: reason)
        
    }
    func cancle() {
        let alert = AlertController(title: " ", message: Localization.canceled, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
            self.router?.goHome()
        }
        
        
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
	// do someting...
}

extension requestDetailsViewController {
	// do someting...
}

extension requestDetailsViewController {
	// do someting...
}
