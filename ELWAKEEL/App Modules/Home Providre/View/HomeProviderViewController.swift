//
//  HomeProviderViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IHomeProviderViewController: class {
	var router: IHomeProviderRouter? { get set }
    func get_request()
    func assign_requests(requests: HomeProviderModel.new_requests)
    func assign_provider_requests(request: HomeProviderModel.provider_request)
    func reject_request_done()
}

class HomeProviderViewController: UIViewController {
	var interactor: IHomeProviderInteractor?
	var router: IHomeProviderRouter?

    @IBOutlet weak var acceptTable: UITableView!
    @IBOutlet weak var Notifications: UILabel!
    @IBOutlet weak var Home: UILabel!
    @IBOutlet weak var requestsTable: UITableView!
    @IBOutlet weak var request_DES: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var servicesRequests: UILabel!
    @IBOutlet weak var sea_all: UIButton!
    
    var near_requests: HomeProviderModel.new_requests?
    var provider_requests: HomeProviderModel.provider_request?
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
       get_provider_requests()
        get_request()
        
    }
    
    func setUpView()
    {
        servicesRequests.text = Localization.Service_requests
        Home.text = Localization.Main
        topView.layer.cornerRadius = 8
        bottomView.layer.cornerRadius = 8
        let uib = UINib(nibName: "acceptCell", bundle: nil)
        acceptTable.register(uib, forCellReuseIdentifier: "acceptCell")
        let uib2 = UINib(nibName: "RequestsCell", bundle: nil)
        requestsTable.register(uib2, forCellReuseIdentifier: "RequestsCell")
      Notifications.layer.cornerRadius = Notifications.frame.width / 2
        Notifications.layer.masksToBounds = true
        request_DES.text = Localization.near_requests
        sea_all.setTitle(Localization.sea_all, for: .normal)
        acceptTable.delegate = self
        acceptTable.dataSource = self
        requestsTable.delegate = self
        requestsTable.dataSource = self
    }
    
    
    @IBAction func notifications(_ sender: Any) {
        router?.notifications()
    }
    
    @IBAction func seeALl(_ sender: Any) {
        
    }
    
    
    @IBAction func show_side_menu(_ sender: Any) {
        router?.go_side_menu()
    }
    
    
}

extension HomeProviderViewController: IHomeProviderViewController {
    func reject_request_done() {
        let alert = AlertController(title: " ", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: Localization.ok, style: .cancel) { (action) in
            self.requestsTable.reloadData()
            
        }
        
        alert.setTitleImage(UIImage(named: "infoormation"))
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 17)!]
        let messageString = NSAttributedString(string: Localization.reject_request_des, attributes: messageAttributes)

        alert.setValue(messageString, forKey: "attributedMessage")
        let constraintHeight = NSLayoutConstraint(
            item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
            NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        alert.view.addConstraint(constraintHeight)

        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
   
    func assign_provider_requests(request: HomeProviderModel.provider_request) {
        self.provider_requests = request
        print("requests\(request)")
        requestsTable.reloadData()
    }
    
    func assign_requests(requests: HomeProviderModel.new_requests) {
    self.near_requests = requests
        acceptTable.reloadData()
        
    }
     func get_provider_requests()
     {
        interactor?.provider_requests()
    }
    
    func get_request() {
        interactor?.get_requests()
    }
    func reject_request(request_id: Int)
    {
        interactor?.reject_reuest(request_id: request_id)
    }
    func go_create_offer(request_id: Int)
    {
        router?.accept_reuest(request_id: request_id)
    }
    
	// do someting...
}

extension HomeProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if tableView == acceptTable
        {
        return near_requests?.data.count ?? 0
        }
        else{
            return provider_requests?.data.count ?? 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == acceptTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "acceptCell", for: indexPath) as! acceptCell
            cell.cancel_action = {
                sender in
                if let id = self.near_requests?.data[indexPath.row].id {
                    self.reject_request(request_id: id)

                }
                print("index path\(indexPath.row)")

            }
            cell.accept_button = {
                    sender in
                if let id = self.near_requests?.data[indexPath.row].id {
                    print("index path\(indexPath.row)")
                    print("accepted")
                    self.go_create_offer(request_id: id)
                    
                }
                
                
            }

            
            var address = near_requests?.data[indexPath.row].country?.name
            address?.append(contentsOf: "-")
            address?.append(contentsOf: near_requests?.data[indexPath.row].city?.name ?? "")
            var delivery = Localization.delivery
            delivery.append(contentsOf: " ")
            delivery.append(contentsOf: near_requests?.data[indexPath.row].address ?? "")
            cell.requestNum.text = near_requests?.data[indexPath.row].request_number
            cell.requestStatus.text = near_requests?.data[indexPath.row].status?.name
            cell.address.text = address
            cell.delivery.text = delivery
            cell.des.text = near_requests?.data[indexPath.row].description
            return cell
            }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsCell", for: indexPath) as! RequestsCell
            var address = provider_requests?.data[indexPath.row].country?.name
            address?.append(contentsOf: " - ")
            address?.append(contentsOf: provider_requests?.data[indexPath.row].city?.name ?? "")
            cell.des.text = provider_requests?.data[indexPath.row].description
            cell.requestStatus.text = provider_requests?.data[indexPath.row].status?.name
            cell.requestNum.text = provider_requests?.data[indexPath.row].request_number
            cell.address.text = address
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == acceptTable{
            return 235
        }
        else{
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let request_id = provider_requests?.data[indexPath.row].id
        {
        if tableView == requestsTable{
            if provider_requests?.data[indexPath.row].status?.key == "progress"{
                router?.go_request_detail_provider(request_id: request_id)
            }
            
        
        else{
           
            router?.go_request_details(request_id: request_id)
            
            
        }
    }
        }
}
    }
extension HomeProviderViewController{
   
}
