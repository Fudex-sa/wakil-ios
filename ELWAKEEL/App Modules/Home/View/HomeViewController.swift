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

protocol IHomeViewController: class {
	var router: IHomeRouter? { get set }
}

class HomeViewController: UIViewController {
	var interactor: IHomeInteractor?
	var router: IHomeRouter?
    let hideView = UIView()
    let popUpView = UIView()
    var currentPopUpVC: UIViewController!
    let userDefault = UserDefaults.standard
   
    @IBOutlet weak var requestTable: UITableView!
    @IBOutlet weak var notificationLBL: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var requestService: UIButton!
    @IBOutlet weak var service_Reques: UILabel!
    @IBOutlet weak var home: UILabel!
    
    
    @IBOutlet weak var rowHeight: NSLayoutConstraint!
    
    var newReuests: [[String:Any]]?
    var imgArr = [  UIImage(named:"topView"),
                    UIImage(named:"topView") ,
                    UIImage(named:"topView") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ,
                    UIImage(named:"profile") ]
    
    
    var names: [String?] = ["sssss","ccccc", nil]
    
    
    var timer = Timer()
    var counter = 0
   weak var delegate: HomeDelegate?
   var hide = true
	override func viewDidLoad() {
        super.viewDidLoad()
    setUpView()
        getAdvertising()

    }
    
    func setUpView()
    {
        
        print("sssssssss")
        print(userDefault.integer(forKey: "id") as Int)
        print(userDefault.string(forKey: "email") ?? "email")
        print(userDefault.string(forKey: "token") ?? "token")
        print(userDefault.string(forKey: "phone") ?? "phone")
        
        print(userDefault.string(forKey: "type") ?? "type")
        let cellNib = UINib(nibName: "requestCell", bundle: nil)
        requestTable.register(cellNib, forCellReuseIdentifier: "requestCell")
        requestTable.rowHeight = 190
         requestTable.delegate = self
        requestTable.dataSource = self
        imageCollection.register(UINib(nibName: "cell", bundle: nil), forCellWithReuseIdentifier: "cell")
        notificationLBL.layer.masksToBounds = true
        notificationLBL.layer.cornerRadius = notificationLBL.frame.width/2
        requestService.layer.masksToBounds = true
        requestService.layer.cornerRadius = requestService.frame.height/2
        imageCollection.layer.masksToBounds = true
        imageCollection.layer.cornerRadius = 10
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imagePageControl.numberOfPages = imgArr.count
        imagePageControl.currentPage = 0
        home.text = Localization.Main
        service_Reques.text = Localization.Service_requests
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        

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
    
    @IBAction func SideMenuVTN(_ sender: Any) {

        showPopUp()
        
    }

    
    
    
    func getAdvertising(){
     self.interactor?.getDevertising()
        
    }
    
    
    @IBAction func notificationBTN(_ sender: Any) {
        
    }
    
    
    @IBAction func newRequestBTN(_ sender: Any) {
        
        self.navigate(type: .modal, module: GeneralRouterRoute.addrequest, completion: nil)
    }
    
}

extension HomeViewController: IHomeViewController {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
        cell.image.image = imgArr[indexPath.row]
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
        return 3
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! requestCell
        cell.layer.cornerRadius = 10
        cell.requestNumLBL.text = "رقم الطلب"
        cell.requestStatus.text = "قيد التنفيذ"
        cell.requestDESLBL.text = "وصف بسيط للخدمة المطلوبة من قبل المستخدم"
        cell.requestAddresBL.text = "الدمام - المنطقة الشرقية"
        if names[indexPath.row] != nil{
        cell.requesteAccept.text = names[indexPath.row]
        }
        else{
            cell.containerView.isHidden = true
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if names[indexPath.row] != nil{
            return 190
            
        }
        else{
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigate(type: .modal, module: GeneralRouterRoute.editRequest, completion: nil)
    }
   

    
}





extension HomeViewController{
    
    
    ///////////////////////////////////////////// popUps ////////////////////////////////////////////
    
    func showPopUp() {
         currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)

        
        
//        let storyBoard = UIStoryboard(name: "SideMenu", bundle: nil)
        hideView.frame = self.view.frame
        hideView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let hideBtn = UIButton()
        hideBtn.frame = CGRect(x: 0, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
        hideView.addSubview(hideBtn)
        hideBtn.addTarget(self, action: #selector(hideBtnTapped), for: .touchUpInside)
        popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
        hideView.addSubview(popUpView)
        currentPopUpVC = sideMenuViewController(nibName: "sideMenuViewController", bundle: nil)
        let vc = currentPopUpVC
        addChild(vc!)
        vc!.view.frame = popUpView.bounds
        popUpView.addSubview(vc!.view)
        vc!.didMove(toParent: self)
        self.view.addSubview(hideView)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.popUpView.frame = CGRect(x: self.view.frame.minX, y: 0, width: self.view.frame.width - 80, height: self.view.frame.height)
        })
    }
    @objc func hideBtnTapped(sender: UIButton!) {
        hidePopUps()
    }
    func hidePopUps() {
        let previousVC = currentPopUpVC
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.popUpView.frame = CGRect(x: self.view.frame.minX - self.popUpView.frame.width, y: self.view.frame.minY, width: self.view.frame.width - 80, height: self.view.frame.height)
        }, completion: { _ in
            previousVC!.willMove(toParent: nil)
            previousVC!.view.removeFromSuperview()
            previousVC!.removeFromParent()
            self.hideView.removeFromSuperview()
        })
    }
}