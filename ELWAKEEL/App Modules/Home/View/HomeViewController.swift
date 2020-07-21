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

protocol IHomeViewController: class {
	var router: IHomeRouter? { get set }
}

class HomeViewController: UIViewController {
	var interactor: IHomeInteractor?
	var router: IHomeRouter?

    
    @IBOutlet weak var notificationLBL: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    @IBOutlet weak var requestService: UIButton!
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
    
    var timer = Timer()
    var counter = 0
   weak var delegate: HomeDelegate?
    let transiton = SlideInTransition()
    let obg = HomeContainerController()
    var topView: UIView?
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    setUpView()
        obg.configureHomeController()
    
        
        
    }
    
    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title
        
        topView?.removeFromSuperview()
        switch menuType {
        case .profile:
            let view = UIView()
            view.backgroundColor = .yellow
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        case .camera:
            let view = UIView()
            view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        default:
            break
        }
    }
    func setUpView()
    {
        
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
//        delegate?.handleMenuToggle()
    }

    func setmenu(){
        
        self.navigate(type: .modal, module: GeneralRouterRoute.sideMenu, completion: nil)
    }
    
    
    @IBAction func notificationBTN(_ sender: Any) {
        
        
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


