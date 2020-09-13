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
import MOLH
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
    var isExpanding = false
    let hideView = UIView()
    let popUpView = UIView()
    var currentPopUpVC: UIViewController!
      
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        get_provider_requests()
        get_request()
        set_up_navigation()
        create_buttons()
        set_notification()
        
    }
    
  
    
    
    func setUpView()
    {
        
        servicesRequests.text = Localization.Service_requests
        topView.layer.cornerRadius = 8
        bottomView.layer.cornerRadius = 8
        let uib = UINib(nibName: "acceptCell", bundle: nil)
        acceptTable.register(uib, forCellReuseIdentifier: "acceptCell")
        let uib2 = UINib(nibName: "RequestsCell", bundle: nil)
        requestsTable.register(uib2, forCellReuseIdentifier: "RequestsCell")
        request_DES.text = Localization.near_requests
        sea_all.setTitle(Localization.sea_all, for: .normal)
        acceptTable.delegate = self
        acceptTable.dataSource = self
        requestsTable.delegate = self
        requestsTable.dataSource = self
    }
    func set_up_navigation()
    {
        let navigationVC = UINavigationController(rootViewController: self)
        
        navigationVC.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationVC.navigationBar.topItem?.title = Localization.Main
        let window = UIApplication.shared.delegate?.window
        
        window?!.rootViewController = navigationVC
        window?!.makeKeyAndVisible()
    }
    
    func create_buttons()
       {
        let side_menu_BTN = UIButton.init(type: .custom)
        side_menu_BTN.setImage(UIImage(named: "sidemenu"), for: UIControl.State.normal)
        side_menu_BTN.addTarget(self, action: #selector(self.side_menu), for: UIControl.Event.touchUpInside)
        side_menu_BTN.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: side_menu_BTN)
        self.navigationItem.leftBarButtonItem = barButton
   
    }
    
    func set_notification()
    {
        let notificationButton = SSBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "Notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        notificationButton.badge = "4"
        notificationButton.addTarget(self, action: #selector(self.notification), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
    }
    
    @objc func side_menu() {

        if !isExpanding{
            
            showPopUp()
        }
        else{
            
            hidePopUps()
            
        }
        isExpanding = !isExpanding
        

    }
    
    @objc func notification(){
 router?.notifications()
        
    }
   
    
    @IBAction func seeALl(_ sender: Any) {
        
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
    
    func showPopUp() {
        
        currentPopUpVC = sideMenuProviderViewController(nibName: "sideMenuProviderViewController", bundle: nil)
        hideView.frame = self.view.frame
        hideView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let hideBtn = UIButton()
        hideBtn.frame = CGRect(x: 0, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
        hideView.addSubview(hideBtn)
        hideBtn.addTarget(self, action: #selector(hideBtnTapped), for: .touchUpInside)
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            popUpView.frame = CGRect(x: self.view.frame.maxX, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
        }
        else{
            popUpView.frame = CGRect(x: self.view.frame.minX - self.view.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
        }
        
        hideView.addSubview(popUpView)
        currentPopUpVC = sideMenuProviderViewController(nibName: "sideMenuProviderViewController", bundle: nil)
        let vc = currentPopUpVC
        addChild(vc!)
        vc!.view.frame = popUpView.bounds
        popUpView.addSubview(vc!.view)
        vc!.didMove(toParent: self)
        self.view.addSubview(hideView)
        
        UIView.animate(withDuration: 1, delay: 0, options: MOLHLanguage.currentAppleLanguage() == "ar" ? .curveEaseOut : .curveEaseOut, animations: {
            if MOLHLanguage.currentAppleLanguage() == "ar"{
                self.popUpView.frame = CGRect(x: 80 , y: 0, width: self.view.frame.width - 80, height: self.view.frame.height)
                
            }
            else{
                self.popUpView.frame = CGRect(x: self.view.frame.minX , y: 0, width: self.view.frame.width - 80, height: self.view.frame.height)
                
            }
            
        })
    }
    @objc func hideBtnTapped(sender: UIButton!) {
        hidePopUps()
    }
    func hidePopUps() {
        let previousVC = currentPopUpVC
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            if MOLHLanguage.currentAppleLanguage() == "ar"{
                self.popUpView.frame = CGRect(x: self.view.frame.maxX, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
            }
            else{
                self.popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 100, height: self.view.frame.height)
            }
            
            self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = 0
        }, completion: { _ in
            previousVC!.willMove(toParent: nil)
            previousVC!.view.removeFromSuperview()
            previousVC!.removeFromParent()
            self.hideView.removeFromSuperview()
            
        })
    }
//            currentPopUpVC = sideMenuProviderViewController(nibName: "sideMenuProviderViewController", bundle: nil)
//          hideView.frame = self.view.frame
//           hideView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//           let hideBtn = UIButton()
//           hideBtn.frame = CGRect(x: 0, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
//           hideView.addSubview(hideBtn)
//           hideBtn.addTarget(self, action: #selector(hideBtnTapped), for: .touchUpInside)
//           popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
//           hideView.addSubview(popUpView)
//           currentPopUpVC = sideMenuProviderViewController(nibName: "sideMenuProviderViewController", bundle: nil)
//           let vc = currentPopUpVC
//           addChild(vc!)
//           vc!.view.frame = popUpView.bounds
//           popUpView.addSubview(vc!.view)
//           vc!.didMove(toParent: self)
//           self.view.addSubview(hideView)
//           UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
//
//               self.popUpView.frame = CGRect(x: self.view.frame.minX , y: 0, width: self.view.frame.width - 80, height: self.view.frame.height)
//
//
//
//           })
//       }
//       @objc func hideBtnTapped(sender: UIButton!) {
//           hidePopUps()
//       }
//       func hidePopUps() {
//           let previousVC = currentPopUpVC
//           UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//
//               self.popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 100, height: self.view.frame.height)
//               self.navigationItem.leftBarButtonItem?.customView?.frame.origin.x = 0
//           }, completion: { _ in
//               previousVC!.willMove(toParent: nil)
//               previousVC!.view.removeFromSuperview()
//               previousVC!.removeFromParent()
//               self.hideView.removeFromSuperview()
//
//           })
//       }
}
