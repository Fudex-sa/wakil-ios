//
//  BaseController.swift
//
//  Created by mohamed abdo on 3/25/18.
//

import UIKit
import Network
import AVFoundation
class BaseController: UIViewController, POPUPModal, Combining, Sounder {
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var notificationBuyerBtn: UIButton!
    
    var subscriptions: Set<Subscriptions> = []
    //This property for hide and unhide navigation bar
    var hiddenNav: Bool = true
    var modeIsSetted: Bool = false
    var emptyScreen: EmptyScreen!
    var maintanceScreen: MaintanceScreen!
    var networkScreen: NetworkFailScreen!
    // This action for any back for all pages
    var imageContainerLoader: UIImageView? = .init()
    var loaderGIF: UIImage = .init()
    let monitor = NWPathMonitor()
    var refreshPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(color: UIColor(hex: "#181928") )
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationItem.setHidesBackButton(true, animated: false)
        if Localizer.current == .arabic {
            self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
            self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
        } else {
            self.navigationController?.view.semanticContentAttribute = .forceLeftToRight
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        }
        self.setupBase()
        self.checkNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.hiddenNav {
            // hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false )
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        self.navigationController?.navigationBar.removeSubviews()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.hiddenNav {
            // hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        removeSubscription()
        stopLoading()
        
    }
    @objc dynamic func bind() {
        
    }
    @IBAction dynamic func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BaseController: BaseViewControllerProtocol, Alertable {
    func setupBase() {
        //reset paginator
        NetworkManager.instance.resetPaginate()
        //binding
    }
}

extension BaseController: PresentingViewProtocol, EmptyScreenContract, MaintanceScreenContract, NetworkFailScreenContract {
    @objc func didError(error: String?) {
        let model = NotificationBuilder()
        model.setBody(error)
            .setTheme(.error)
            .bulid()
    }
}

extension BaseController {
   
    func checkNetwork() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [self] path in
            DispatchQueue.main.async {
                if monitor.currentPath.status == .satisfied {
                    print("We're connected!")
//                    if UIApplication.topViewController() is Sorryactive && Constants.isconnet == false{
//                        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
//                        Constants.isconnet = true
//                    }
                } else {
//                    print("We're not!")
//                    if UIApplication.topViewController() is Sorryactive { return }
//                    Constants.isconnet = false
//                    let vcc = self.controller(Sorryactive.self,storyboard: .saller)
//                    vcc.txtstring = "The network is fail down please try again".localized
//                    vcc.isupload = false
//                    vcc.isNetworkFail = true
//                    pushPop(vcc)
                    
                }
            }
            
            
            print(monitor.currentPath.status)
            
            
        }
    }
}
