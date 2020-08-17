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
protocol Irequest_detailsViewController: class {
	var router: Irequest_detailsRouter? { get set }
}

class request_detailsViewController: UIViewController {
	var interactor: Irequest_detailsInteractor?
	var router: Irequest_detailsRouter?

    
    
    @IBOutlet weak var request_details: UILabel!
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        request_details.text = Localization.Order_details
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
        start_excutions.text = Localization.star_excution
        start_excutions_DES.text = Localization.start_excution_DES
        chat.text = Localization.conversation
        cancel.setTitle(Localization.cancel_mission, for: .normal)
        start.setTitle(Localization.star_excution, for: .normal)
        cancel.layer.cornerRadius = 10
        cancel.layer.masksToBounds = true
        start.layer.cornerRadius = 10
        start.layer.masksToBounds = true
        clinet_image.layer.cornerRadius = clinet_image.frame.width / 2
        clinet_image.layer.masksToBounds = true
        
        
    }
    
    @IBAction func chat_BTN(_ sender: Any) {
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss()

    }
    
    @IBAction func excution(_ sender: Any) {
    }
    
    
    @IBAction func cancel(_ sender: Any) {
    }
}

extension request_detailsViewController: Irequest_detailsViewController {
	// do someting...
}

extension request_detailsViewController {
	// do someting...
}

extension request_detailsViewController {
	// do someting...
}
