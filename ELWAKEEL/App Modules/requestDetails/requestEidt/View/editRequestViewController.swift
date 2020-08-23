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
    func requestDetails(id: Int)
    func asgniDetails(requestDetail: editRequestModel.RequestDetails)
    func cancelRequest(id: Int, reason: String)
    func backToHome()
    func cancle()
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
    @IBOutlet weak var editLBL: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var titleDES: UILabel!
    
    
    var id: Int?
    var reason = ""
    var requestDetail: editRequestModel.RequestDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        print("ssss\(id)")
        requestDetails(id: id!)
    }
    
    func setUpView(){
        editLBL.text = Localization.request_edit
        edit.layer.cornerRadius = 10
        cancel.layer.cornerRadius = 10
        orderDES.text = Localization.request_DES
        orderStatus.text = Localization.Under_processing
        region.text = Localization.Region
        city.text = Localization.city
        address.text = Localization.Authority_address
        minstry.text = Localization.minstryAndAuth
        achieve.text = Localization.achievement
        title1.text = Localization.title_name
        textView.delegate = self
        edit.setTitle(Localization.edit, for: .normal)
        cancel.setTitle(Localization.cancel, for: .normal)
        
    }
    
    @IBAction func editBTN(_ sender: Any) {
        if let id = self.id {
         self.navigate(type: .modal, module: GeneralRouterRoute.edit(id: id), completion: nil)
        }
        
    }
    
    @IBAction func cancelBTN(_ sender: Any) {
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
    
    @IBAction func backBTN(_ sender: Any) {
        dismiss()
    }
    func configueUI()
    {
        orderNum.text = requestDetail?.request_number
        orderStatus.text = requestDetail?.status?.name
        textView.text = requestDetail?.description
        region1.text = requestDetail?.country.name
        city1.text = requestDetail?.city.name
        address1.text = requestDetail?.address
        minstry1.text = requestDetail?.organization.name
        achieve1.text = requestDetail?.achievement_proof
        titleDES.text = requestDetail?.title
        
    }
    
}

extension editRequestViewController: IeditRequestViewController {
    func cancle() {
        let alert = AlertController(title: " ", message: Localization.canceled, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
            self.router?.goHome()
        }
        
       
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func backToHome() {
        self.router?.goHome()
    }
    
    func cancelRequest(id: Int, reason: String) {
        self.interactor?.cancelRequest(id: id, reason: reason)
    }
    
    
    func asgniDetails(requestDetail: editRequestModel.RequestDetails) {
        self.requestDetail = requestDetail
        configueUI()

    }
    
    func requestDetails(id: Int) {
        interactor?.getRequest_Datails(id: id)
    }
    
    
    
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
