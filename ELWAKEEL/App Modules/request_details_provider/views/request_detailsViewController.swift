//
//  request_detailsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import Cosmos
protocol Irequest_detailsViewController: class {
	var router: Irequest_detailsRouter? { get set }
    func assign_request_details(request: request_detailsModel.provider_Request_Details?)
     func cancle()
    func done_request()
    func go_home()
    func evaluate_clinet()
}

class request_detailsViewController: UIViewController {
	var interactor: Irequest_detailsInteractor?
	var router: Irequest_detailsRouter?

    
    
    @IBOutlet weak var requets_num: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var request_DES: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var minstry: UILabel!
    @IBOutlet weak var proveMent: UILabel!
    @IBOutlet weak var requred_paper: UILabel!
    @IBOutlet weak var required_papers_DES: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var duration_DES: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var price_DES: UILabel!
    @IBOutlet weak var clint_name_DES: UILabel!
    @IBOutlet weak var clinet_image: UIImageView!
    @IBOutlet weak var cline_name: UILabel!
    @IBOutlet weak var chat: UILabel!
    @IBOutlet weak var start_excutions: UILabel!
    @IBOutlet weak var start_excutions_DES: UILabel!
    @IBOutlet weak var region2: UILabel!
    @IBOutlet weak var city2: UILabel!
    @IBOutlet weak var address2: UILabel!
    @IBOutlet weak var provemnet2: UILabel!
    @IBOutlet weak var minstry2: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var start: UIButton!
 
    var request_id: Int?
    var request_detail: request_detailsModel.provider_Request_Details?
    var rating: Int?
    var client_id: Int?
    var client_image_url: String?
    var param: [String: Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        get_request_details()
    }
    
    func setUpView()
    {
       
        request_DES.text = Localization.request_DES
        region.text = Localization.Region
        city.text = Localization.city
        address.text = Localization.Authority_address
        minstry.text = Localization.minstryAndAuth
        proveMent.text = Localization.achievement
        requred_paper.text = Localization.required_paper
        duration.text = Localization.period_of_work
        price.text = Localization.price
        clint_name_DES.text = Localization.serviceRequester
        start_excutions.text = Localization.task_done
        start_excutions_DES.text = Localization.task_done_des
        chat.text = Localization.conversation
        cancel.setTitle(Localization.cancel_mission, for: .normal)
        start.setTitle(Localization.task_done, for: .normal)
        cancel.layer.cornerRadius = 10
        cancel.layer.masksToBounds = true
        start.layer.cornerRadius = 10
        start.layer.masksToBounds = true
        clinet_image.layer.cornerRadius = clinet_image.frame.width / 2
        clinet_image.layer.masksToBounds = true
        self.navigationItem.title = Localization.Order_details
        price_DES.adjustsFontSizeToFitWidth = true
        duration_DES.adjustsFontSizeToFitWidth = true

        
        
    }
  
    func configueUI()
    {
        if let details = self.request_detail{
            
            requets_num.text = details.request_number
            textView.text = details.description
            region2.text = details.country.name
            city2.text = details.city.name
            address2.text = details.address
            minstry2.text = details.organization.name
            provemnet2.text = details.achievement_proof
            cline_name.text = details.client?.name
            required_papers_DES.text = details.offer?.required_paper
            duration_DES.text = details.offer?.duration
            price_DES.text = details.offer?.price_after_tax
            
        }
        
        
    }
    
    func get_request_details()
    {
        if let request_id = request_id{
        interactor?.get_request_details(request_id: request_id )
    }
    }
    @IBAction func chat_BTN(_ sender: Any) {
        print("chat")
        if let parameters = param{
            print("hamada")
            router?.go_chat(param: parameters)
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss()

    }
    
    @IBAction func excution(_ sender: Any) {
        
        done_request()
//        evaluate_clinet()
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        
        let alert = UIAlertController(title: Localization.cancelRequest, message: Localization.cancelReason, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
             let reason = (alert.textFields?[0].text)!
            if let request_id = self.request_id{
              self.interactor?.cancelRequest(request_id: request_id,reason: reason)
            }
        }
        
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .default) { (action) in
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
    }
    
   
    
}

extension request_detailsViewController: Irequest_detailsViewController {
    func go_home() {
        router?.go_home()
    }
    
    func evaluate_clinet()
    {
        
        let alertController = AlertController(title: Localization.client_evaluate, message: nil, preferredStyle: .alert)
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
        customView.settings.fillMode = .full
        customView.settings.starSize = 30
        customView.settings.starMargin = 5
        customView.rating = 0.0
        customView.settings.filledImage = UIImage(named: "fill")
        customView.settings.emptyImage = UIImage(named: "empty")
        customView.didFinishTouchingCosmos = { rating in
            self.rating = Int(rating)
            
            

        }
        let evaluate = UIAlertAction(title: Localization.evaluate, style: .default) { (action) in
            
            if let rate = self.rating, let user_id = self.client_id, let request_id = self.request_id{
                self.interactor?.rating(rate: rate, user_id: user_id, request_id: request_id)
            }
            
        }
        
        alertController.addAction(evaluate)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func done_request() {
        
        let alert = AlertController(title: " ", message: Localization.done_request, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
            if let request_id = self.request_id{
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
            self.go_home()
        }
        
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func assign_request_details(request: request_detailsModel.provider_Request_Details?) {
      
            if let request = request {
                self.request_detail = request
                self.client_id = request.client?.id
                self.client_image_url = "http://wakil.dev.fudexsb.com"
                client_image_url?.append(contentsOf: request.client?.image ?? "")
                configueUI()
                if let provider_id = request.offer?.provider.id, let client_id = request.client?.id, let request_id = request_id{
                    param = ["service_id": request_id, "client_id": client_id, "provider_id":  provider_id]
                }
                
            }
    }
    
	// do someting...
}

extension request_detailsViewController {
	// do someting...
}

extension request_detailsViewController {
	// do someting...
}
