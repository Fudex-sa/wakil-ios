//
//  Accept_RequestViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
//import MGStarRatingView
import LocalizationFramework

protocol IAccept_RequestViewController: class {
	var router: IAccept_RequestRouter? { get set }
    func assign_offer(offers: Accept_RequestModel.offer)
}

class Accept_RequestViewController: UIViewController {
	var interactor: IAccept_RequestInteractor?
	var router: IAccept_RequestRouter?
    var offers: Accept_RequestModel.offer?
    
    @IBOutlet weak var all_requests: UILabel!
    @IBOutlet weak var accept: UILabel!
    @IBOutlet weak var all_request_des: UILabel!
    @IBOutlet weak var accepts_table: UITableView!
    
    var request_Id: Int?
    var offer_id: Int?
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    print("sssdddd\(request_Id)")
        setUpview()
        get_offers()
    }
    
    func setUpview()
    {
        let nib = UINib(nibName: "accept", bundle: nil)
        accepts_table.register(nib, forCellReuseIdentifier: "accept")
        accepts_table.delegate = self
        accepts_table.dataSource = self
        accept.text = Localization.requests_addmision
        all_requests.text = Localization.all_provider_offers
        all_request_des.text = Localization.one_request
        
    }
    
    @IBAction func back_BTN(_ sender: Any) {
        dismiss()
    }
    
    
    func get_offers()
    {
        if let request_Id = request_Id{
            interactor?.get_offers(id: request_Id)

        }
    }
}

extension Accept_RequestViewController: IAccept_RequestViewController {
    func assign_offer(offers: Accept_RequestModel.offer) {
        self.offers = offers
        accepts_table.reloadData()
        print("oferr\(offers)")
    }
    
	// do someting...
}

extension Accept_RequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accept", for: indexPath) as! accept
        cell.provider_name.text = offers?.data[indexPath.row].provider?.name
        if let price = offers?.data[indexPath.row].price_after_tax{
            cell.price.text = String(describing: price) + " " + Localization.SR

        }
        cell.cancel_action = {
            sender in
           
            if let id = self.offers?.data[indexPath.row].id, let requets_id = self.request_Id{
                self.showAlert(offer_id: id, request_id: requets_id)
            }
            
        }
        cell.rating.rating = Double(offers?.data[indexPath.row].provider?.average_rating ?? "") ?? 0.0
        cell.rating.isUserInteractionEnabled = false
//        cell.rating.didFinishTouchingCosmos = {
//            action in
//            print("cccc\(action)")
//        }
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
extension Accept_RequestViewController{
   
    
    func showAlert(offer_id: Int, request_id: Int)
    {
        let params: [String: Any] = ["offer_id": offer_id, "request_id": request_id]
        let alert = AlertController(title: " ", message: Localization.pay, preferredStyle: .alert)
        
        let sendAction = UIAlertAction(title: Localization.next, style: .default) { (action) in
            self.router?.go_payment(params: params)
            
        }
        let cancel = UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil)
        
        alert.setTitleImage(UIImage(named: "notification_image"))
        
        alert.addAction(sendAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
}
extension Accept_RequestViewController{
    
//    private func didFinishTouchingCosmos(_ rating: Double) {
//        ratingSlider.value = Float(rating)
//        self.ratingLabel.text = ViewController.formatValue(rating)
//        ratingLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
//    }
}
//    func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
//        print("value changed")
//    }
//
//
//     do someting...

