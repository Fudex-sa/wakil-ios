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
    func assign_wallet(wallet: walletModel.wallet)
}

class walletViewController: UIViewController {
	var interactor: IwalletInteractor?
	var router: IwalletRouter?

    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var advertizingImg: UIImageView!
    @IBOutlet weak var operations: UILabel!
    @IBOutlet weak var opertionsTable: UITableView!
    var wallets: walletModel.wallet?
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var commsion: UILabel!
    var provider_price = Localization.SR
    let commision1 = Localization.app_commsion
    let commision2 = Localization.app_commsion1
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        get_wallet()
        
        
    }
    
    func setUpView()
    {
        wallet.text = Localization.your_wallet
        opertionsTable.delegate = self
        opertionsTable.dataSource = self
        let nib = UINib(nibName: "wallet", bundle: nil)
        opertionsTable.register(nib, forCellReuseIdentifier: "wallet")
        operations.text = Localization.operations
    self.navigationItem.title = Localization.wallet
        
    }
    func get_wallet()
    {
        interactor?.get_wallet()
    }
    
   
    
}

extension walletViewController: IwalletViewController {
    func assign_wallet(wallet: walletModel.wallet) {
        self.wallets = wallet
        if let wallet_price = wallet.wallet , let commission = wallet.commissions{
            price.text = String(describing: wallet_price) + " " + provider_price
            commsion.text = commision1 + "%" + String(describing: commission) + commision2
            opertionsTable.reloadData()
        }
       
    }
    
	// do someting...
}

extension walletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets?.requests.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath) as! wallet

        cell.providerName.text = wallets?.requests.data[indexPath.row].client?.name
        cell.price.text = String(describing: 15) + " " + Localization.SR
        cell.date.text = "12-5"
        var  url = "http://wakil.dev.fudexsb.com"
        url.append(contentsOf: wallets?.requests.data[indexPath.row].client?.image ?? "")
        UIImage.loadFrom(url: URL(string: url)!) { (image) in
            cell.profileImg.image = image
              
                          }
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
