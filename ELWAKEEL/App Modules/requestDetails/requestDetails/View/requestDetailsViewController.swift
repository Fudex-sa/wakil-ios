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
import Cosmos

protocol IrequestDetailsViewController: class {
	var router: IrequestDetailsRouter? { get set }
    func cancelRequest(id: Int, reason: String)
    func cancle()
    func get_request_details(request_id: Int)
    func assign_request_details(request: requestDetailsModel.RequestDetails?)
    func evaluate_provider()
    func done_request()
    func go_home()
}

class requestDetailsViewController: UIViewController {
	var interactor: IrequestDetailsInteractor?
	var router: IrequestDetailsRouter?

    
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
    
    @IBOutlet weak var canel: UIButton!
    @IBOutlet weak var required_papers1: UILabel!
    @IBOutlet weak var title_des: UILabel!
    @IBOutlet weak var requiref_paper2: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var not_done: UIButton!
    
    
    @IBOutlet weak var SR: UILabel!
    
    var reason = ""
    var id: Int?
    var request_details: requestDetailsModel.RequestDetails?
    var provider_image_url: String?
    var rating: Int?
    var provider_id: Int?
    var statu: String?
    var params: [String: Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    
        
        setUpView()
        create_side_button()
        set_up_navigation()
    }
    
    func setUpView()
    {
        providerIMG.layer.cornerRadius = providerIMG.frame.width/2
        providerIMG.layer.masksToBounds = true
        
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
//        currency.text = Localization.SR
        titleLBL.text = Localization.title_name
        serviceprovidername.text = Localization.serviceSupplierName
        required_papers1.text = Localization.required_paper
        SR.text = Localization.SR
        done.setTitle(Localization.task_done, for: .normal)
        not_done.setTitle(Localization.not_done, for: .normal)
       
        done.layer.cornerRadius = 10
        done.layer.masksToBounds = true
        not_done.layer.cornerRadius = 10
        not_done.layer.masksToBounds = true
        if let id = id{
            get_request_details(request_id: id)
        }
        if statu == "progress"{
          done.isEnabled = false
            not_done.isEnabled = false
            done.alpha = 0.5
            not_done.alpha = 0.5
    }
        else{
            done.isEnabled = true
            not_done.isEnabled = true
            done.alpha = 1.0
            not_done.alpha = 1.0
        }
        
       
        
    
    }
    func set_up_navigation()
    { self.navigationItem.title = Localization.Order_details
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)

    }
    func create_side_button()
    {
        
        let side_menu_BTN = UIButton.init(type: .custom)
        side_menu_BTN.setImage(UIImage(), for: UIControl.State.normal)
        side_menu_BTN.addTarget(self, action: #selector(self.cancelBTN), for: UIControl.Event.touchUpInside)
            side_menu_BTN.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
 side_menu_BTN.setTitle(Localization.cancel, for: .normal)
            let barButton = UIBarButtonItem(customView:side_menu_BTN)
                         self.navigationItem.rightBarButtonItem = barButton
               
    }
    @objc func cancelBTN(){
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
    
    @IBAction func done(_ sender: Any) {
        
        if let id = id{
        interactor?.done_request(request_id: id )
        }
    }
    
    
    @IBAction func not_done(_ sender: Any) {
        let alert = UIAlertController(title: Localization.cancelRequest, message: Localization.cancelReason, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
            let reason = (alert.textFields?[0].text)!
            if let id = self.id{
                self.interactor?.not_done_request(request_id: id, reason: reason)
            }
        }
        
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .default) { (action) in
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
        
    }
    
    @IBAction func chatBTN(_ sender: Any) {
        if let parameters = params{
            router?.go_chat(params: parameters )

        }
        
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        
    }
    @IBAction func recive(_ sender: Any) {
        
        done_request()
        
        
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
        title_des.text = request_details?.title
        if let price = request_details?.offer?.price_after_tax{
            currency.text = String(describing: price)
            
        }
     
        
    }
    
}

extension requestDetailsViewController: IrequestDetailsViewController {
    func go_home() {
        router?.goHome()
    }
    
    func evaluate_provider() {
            let alertController = AlertController(title: Localization.provider_evaluate, message: nil, preferredStyle: .alert)
            let customView = CosmosView()
            alertController.view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 150).isActive = true
            customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -40).isActive = true
            customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 45).isActive = true
            
            customView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
            alertController.setTitleImage(UIImage(named: "profile"))
            //        if let image_url = client_image_url{
            //            UIImage.loadFrom(url: URL(string: image_url)!) { (image) in
            //       alertController.setTitleImage(image)
            //
            //            }
            //        }
            print("url\(provider_image_url)")
            
            customView.settings.fillMode = .full
            customView.settings.starSize = 30
            customView.settings.starMargin = 5
            customView.rating = 0.0
            customView.settings.filledImage = UIImage(named: "fill")
            customView.settings.emptyImage = UIImage(named: "empty")
            customView.didFinishTouchingCosmos = { rating in
                self.rating = Int(rating)
                print("rating\(rating)")
                
            }
            let evaluate = UIAlertAction(title: Localization.evaluate, style: .default) { (action) in
                
                if let rate = self.rating, let user_id = self.provider_id, let request_id = self.id{
                    self.interactor?.rating(rate: rate, user_id: user_id, request_id: request_id)
                }
                
            }
            
            alertController.addAction(evaluate)
            self.present(alertController, animated: true, completion: nil)
        }
    
    func assign_request_details(request: requestDetailsModel.RequestDetails?) {
        if let request = request {
            self.request_details = request
            self.provider_id = request.provider?.id
            if let provider_id = request.offer?.provider.id, let client_id = request.client?.id{
                params = ["service_id": request.id, "client_id": client_id, "provider_id":  provider_id]
            }
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.configueUI()
                }
            }
            
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
    func done_request() {
        
        let alert = AlertController(title: " ", message: Localization.done_request, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
            if let request_id = self.id{
                self.interactor?.done_request(request_id: request_id)
            }
            
        }
        let cancel = UIAlertAction(title: Localization.cancel, style: .cancel) { (action) in
        }
        
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
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
