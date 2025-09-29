//
//  PaymentmethodVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 21/09/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol PaymentmethodVCDelegate: AnyObject {
    func done(model : Int)

}
// MARK: - ...  ViewController - Vars
class PaymentmethodVC: BaseController {
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var paymentmethodTbl: UITableView!
    var viewModel: PaymentmethodViewModel?
    var coordinator: PaymentmethodCoordinator?
    var paymentmethod: PaymethodModel?
    var delegate: PaymentmethodVCDelegate?
    var paymentId = 0
}

// MARK: - ...  LifeCycle
extension PaymentmethodVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension PaymentmethodVC {
    func setup() {
        paymentmethodTbl.skeleton()
        paymentmethodTbl.delegate = self
        paymentmethodTbl.dataSource = self
        paymentmethodTbl.observe()
        paymentmethodTbl.reloadData()
        payBtn.publisher.listen(on: {[weak self] _ in
            if self?.paymentId ?? 0 == 0 {
                self?.didError(error: "Choose appropriate payment method".localized)
                return
            }
            self?.delegate?.done(model: self?.paymentId ?? 0)
            self?.dismiss(animated: true, completion: nil)
               
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension PaymentmethodVC {
}
extension PaymentmethodVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentmethod?.data?.paymentMethods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PaymentmethodTableViewCell.self, indexPath)
        cell.model = paymentmethod?.data?.paymentMethods?[safe: indexPath.row]
        cell.id = paymentId
        cell.setup()
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

extension PaymentmethodVC : PaymentmethodTableViewCellDelegate {
    func done(wasPressedOnCell cell: PaymentmethodTableViewCell, model: PaymentMethod) {
        paymentId = model.paymentMethodID ?? 0
        paymentmethodTbl.reloadData()
    }
}
