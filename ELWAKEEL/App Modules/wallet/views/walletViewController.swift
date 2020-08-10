//
//  walletViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IwalletViewController: class {
	var router: IwalletRouter? { get set }
}

class walletViewController: UIViewController {
	var interactor: IwalletInteractor?
	var router: IwalletRouter?

    @IBOutlet weak var homeWallet: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var advertizingImg: UIImageView!
    @IBOutlet weak var operations: UILabel!
    @IBOutlet weak var opertionsTable: UITableView!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
    }
    
    func setUpView()
    {
        homeWallet.text = Localization.wallet
        wallet.text = Localization.your_wallet
        opertionsTable.delegate = self
        opertionsTable.dataSource = self
        let nib = UINib(nibName: "wallet", bundle: nil)
        opertionsTable.register(nib, forCellReuseIdentifier: "wallet")
        operations.text = Localization.operations

        
    }
    
    
    
    @IBAction func sidemneu(_ sender: Any) {
    }
    
    
}

extension walletViewController: IwalletViewController {
	// do someting...
}

extension walletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath) as! wallet
        
        cell.date.text = "3: 55 مساء الإثنين"
        cell.price.text = "15 ريال سعودي"
        cell.providerName.text = "إسم طالب الخدمة"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
	// do someting...
}

extension walletViewController {
	// do someting...
}
