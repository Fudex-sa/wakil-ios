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

protocol IrequestDetailsViewController: class {
	var router: IrequestDetailsRouter? { get set }
}

class requestDetailsViewController: UIViewController {
	var interactor: IrequestDetailsInteractor?
	var router: IrequestDetailsRouter?

    
    @IBOutlet weak var reqDEtails: UILabel!
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
    @IBOutlet weak var recitp: UIButton!
    
    
    
    @IBOutlet weak var canel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    
        setUpView()
    }
    
    func setUpView()
    {
        providerIMG.layer.cornerRadius = providerIMG.frame.width/2
        providerIMG.layer.masksToBounds = true
        reqDEtails.text = Localization.Order_details
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
        currency.text = Localization.SR
        serviceprovidername.text = Localization.serviceSupplierName
        recitp.setTitle(Localization.Receipt, for:.normal)
        canel.setTitle(Localization.cancel, for: .normal)
        
    }
    
    @IBAction func chatBTN(_ sender: Any) {
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
     let alert = AlertController(title: Localization.cancel_oredr, message: Localization.cancel_order_DES, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .cancel, handler: nil)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
            print("hamada")
        }
        
        alert.setTitleImage(UIImage(named: "infoormation"))

        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func recive(_ sender: Any) {
        
    }
    
}

extension requestDetailsViewController: IrequestDetailsViewController {
	// do someting...
}

extension requestDetailsViewController {
	// do someting...
}

extension requestDetailsViewController {
	// do someting...
}
