//
//  detailsViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IdetailsViewController: class {
	var router: IdetailsRouter? { get set }
    func assign_request_details(request: detailsModel.Request_Details?)

}

class detailsViewController: UIViewController {
	var interactor: IdetailsInteractor?
	var router: IdetailsRouter?
    @IBOutlet weak var request_num: UILabel!
    @IBOutlet weak var request_details: UILabel!
    @IBOutlet weak var requets_status: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title_des: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var des_view: UITextView!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var region_des: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var city_des: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var address_des: UILabel!
    @IBOutlet weak var minstry: UILabel!
    @IBOutlet weak var minstry_des: UILabel!
    @IBOutlet weak var prove: UILabel!
    @IBOutlet weak var prove_des: UILabel!
    var request_id: Int?
    var request_detail: detailsModel.Request_Details?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        
        get_request_details()
    }
    
    func setUpView()
    {
        request_details.text = Localization.Order_details
        des.text = Localization.request_DES
        region.text = Localization.Region
        city.text = Localization.city
        address.text = Localization.Authority_address
        minstry.text = Localization.minstryAndAuth
        prove.text = Localization.achievement
        title1.text = Localization.title_name
    }
    
    
    func configueUI()
    {
        request_num.text =  request_detail?.request_number
        requets_status.text = request_detail?.status?.key
        des_view.text = request_detail?.description
        region_des.text = request_detail?.country.name
        city_des.text = request_detail?.city.name
        address_des.text = request_detail?.address
        minstry_des.text = request_detail?.organization.name
         title_des.text = request_detail?.title
        prove_des.text = request_detail?.achievement_proof
        
        }
    @IBAction func dismiss(_ sender: Any) {
        
        
        dismiss()
    }
    
    
}

extension detailsViewController: IdetailsViewController {
    func assign_request_details(request: detailsModel.Request_Details?) {
    
            if let request = request {
                self.request_detail = request
                configueUI()
            }
        }
        
        func get_request_details() {
            if request_id != nil{
                interactor?.get_request_details(request_id: request_id!)
            }
            
        }
    
    }

extension detailsViewController {
	// do someting...
}

extension detailsViewController {
	// do someting...
}
