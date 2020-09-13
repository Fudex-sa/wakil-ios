//
//  HomeViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/16/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import MOLH
protocol IHomeViewController: class {
    var router: IHomeRouter? { get set }
    func assignRequests(requests: HomeModel.requests)
    func assignAdvertizing(advertizing: [HomeModel.Advertising])
    func go_offers(request_id: Int)
}
protocol HomePrivderCenterControllerDelegate {
    func handleMenuToggle()
    func handleCenter()
}

class HomeViewController: UIViewController {
    var interactor: IHomeInteractor?
    var router: IHomeRouter?
    let hideView = UIView()
    let popUpView = UIView()
    var currentPopUpVC: UIViewController!
    let userDefault = UserDefaults.standard
    var advertizings: [HomeModel.Advertising]?
    
    @IBOutlet weak var requestTable: UITableView!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var requestService: UIButton!
    @IBOutlet weak var service_Reques: UILabel!
    @IBOutlet weak var home: UILabel!
    
    
    @IBOutlet weak var rowHeight: NSLayoutConstraint!
    
    var newReuests: [[String:Any]]?
    var imgArr: [String] = [String]()
    var names: [String?] = ["sssss","ccccc", nil]
    var requests2: HomeModel.requests?
    var rrrr: HomeModel.requests?
    
    var timer = Timer()
    var counter = 0
    var hide = true
    var id = 0
    var provider_id: Int?
    var advertizing_id: Int?
    var isExpanding = false
    var barButton : UIBarButtonItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getAdvertising()
        getrequests()
        create_buttons()
        set_notification()
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        if isExpanding{
    //            hidePopUps()
    //        }
    //    }
    
    
    func getrequests()
    {
        interactor?.getRequest()
        requestTable.reloadData()
        
    }
    func setUpView()
    {
        
        let navigationVC = UINavigationController(rootViewController: self)
        
        navigationVC.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        navigationVC.navigationBar.topItem?.title = Localization.login
        let window = UIApplication.shared.delegate?.window
        
        window?!.rootViewController = navigationVC
        window?!.makeKeyAndVisible()
        
        let cellNib = UINib(nibName: "requestCell", bundle: nil)
        requestTable.register(cellNib, forCellReuseIdentifier: "requestCell")
        
        let nib = UINib(nibName: "advertizingCell", bundle: nil)
        imageCollection.register(nib, forCellWithReuseIdentifier: "advertizingCell")
        requestTable.rowHeight = 190
        requestTable.delegate = self
        requestTable.dataSource = self
        imageCollection.layer.masksToBounds = true
        imageCollection.layer.cornerRadius = 10
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imagePageControl.numberOfPages = imgArr.count
        imagePageControl.currentPage = 0
        self.navigationItem.title = Localization.Main
        
        service_Reques.text = Localization.Service_requests
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "BackGround"), for: UIBarMetrics.default)
       }
    
    func create_buttons()
    {
        let side_menu_BTN = UIButton.init(type: .custom)
        side_menu_BTN.setImage(UIImage(named: "sidemenu"), for: UIControl.State.normal)
        side_menu_BTN.addTarget(self, action: #selector(self.side_menu), for: UIControl.Event.touchUpInside)
        side_menu_BTN.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        barButton = UIBarButtonItem(customView: side_menu_BTN)
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
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.imageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            imagePageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.imageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            imagePageControl.currentPage = counter
            counter = 1
        }
        
    }
    
    
    @IBAction func serviceRequest(_ sender: Any) {
        router?.addRequest()
        
        print("private")
        
    }
    
    
    func getAdvertising(){
        self.interactor?.getDevertising()
        
    }
    
    
    @IBAction func notificationBTN(_ sender: Any) {
        
        router?.notifications()
    }
    
    
    @IBAction func newRequestBTN(_ sender: Any) {
        
        router?.addRequest()
    }
    
    
}

extension HomeViewController: IHomeViewController {
    func go_offers(request_id: Int) {
        self.router?.go_offer(request_id: request_id)
    }
    
    func assignAdvertizing(advertizing: [HomeModel.Advertising]) {
        self.advertizings = advertizing
        if let advertizings = advertizings{
            for item in advertizings{
                var baseUrl = "http://wakil.dev.fudexsb.com"
                baseUrl.append(contentsOf: item.image)
                self.imgArr.append(baseUrl)
            }
            
            self.imageCollection.reloadData()
        }
    }
    
    func assignRequests(requests: HomeModel.requests) {
        self.requests2 = requests
        
        self.requestTable.reloadData()
        
        
        
    }
    
    // do someting...
}

extension HomeViewController {
    
    // do someting...
}

extension HomeViewController {
    // do someting...
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "advertizingCell", for: indexPath) as! advertizingCell
        cell.image.image = UIImage(named: imgArr[indexPath.row])
        cell.get_provider_id = {
            action in
            self.provider_id = self.advertizings?[indexPath.row].providerID
            self.advertizing_id = self.advertizings?[indexPath.row].id
            
            
            if let ads_id =  self.advertizing_id, let providerID = self.provider_id{
                self.router?.go_special_request(params: ["provider_id": providerID,"advertizing_id": ads_id])
                
            }
            
            
        }
        if let url = URL(string: imgArr[indexPath.row]) {
            UIImage.loadFrom(url: url) { image in
                cell.image.image = image
            }
        }
        else{
            print("no image found")
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imageCollection.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests2?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! requestCell
        cell.layer.cornerRadius = 10
        cell.requestNumLBL.text = requests2?.data[indexPath.row].request_number
        cell.requestStatus.text = (requests2?.data[indexPath.row].status?.name)
        
        if requests2?.data[indexPath.row].status?.key == "new" &&
            requests2?.data[indexPath.row].offersCount == 0 {
            cell.new.isHidden = false
            cell.showNumberLBL.isHidden = true
        }
        else if requests2?.data[indexPath.row].status?.key == "new" &&
            requests2?.data[indexPath.row].offersCount != 0{
            cell.showNumberLBL.isHidden = false
            cell.showNumberLBL.text = String(describing: requests2?.data[indexPath.row].offersCount ?? 0)
            cell.requestNum2.text = String(describing: self.requests2?.data[indexPath.row].offersCount ?? 0)
            
            cell.new.isHidden = true
            cell.requests_action = {
                sender in
                if let id = self.requests2?.data[indexPath.row].id
                {
                    self.go_offers(request_id: id)
                    
                    
                }
            }
            
        }
        else{
            cell.showNumberLBL.isHidden
                = true
        }
        
        cell.requestDESLBL.text = requests2?.data[indexPath.row].description
        var address = requests2?.data[indexPath.row].city?.name ?? ""
        address.append(contentsOf: " - ")
        address.append(contentsOf: requests2?.data[indexPath.row].country?.name ?? "" )
        cell.requesteAccept.text = Localization.requestsApprove
        cell.requestAddresBL.text = address
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if requests2?.data[indexPath.row].status?.key == "new" &&
            requests2?.data[indexPath.row].offersCount == 0 {
            return 135
            
        }
        else if requests2?.data[indexPath.row].status?.key == "new" &&
            requests2?.data[indexPath.row].offersCount != 0 {
            return 230
        }
            
        else{
            return 135
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request_id = (requests2?.data[indexPath.row].id)!
        if requests2?.data[indexPath.row].status?.key == "new"
        {
            
            router?.edit_request(request_id: request_id)
        }
        else if requests2?.data[indexPath.row].status?.key == "progress"{
            
            router?.request_details(request_id: request_id, status: "progress")
        }
        else {
            
            router?.request_details(request_id: request_id, status: "done")
            
        }
        
    }
    
    
    
}




extension HomeViewController{
    
    
    
    func showPopUp() {
        
        currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)
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
        //        popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: 0, height: self.view.frame.height)
        hideView.addSubview(popUpView)
        currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)
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
}


extension UIImage {
    
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    
    
    
}
