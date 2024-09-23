//
//  PaymentMethodVC.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol PaymentMethodVCCDelegate: AnyObject {
    func done(paymentId : Int)
}
// MARK: - ...  ViewController - Vars
class PaymentMethodVC: BaseController {
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var paymentTbl: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: PaymentMethodViewModel?
    var coordinator: PaymentMethodCoordinator?
    weak var delegate: PaymentMethodVCCDelegate?
    var methodId = 0
}

// MARK: - ...  LifeCycle
extension PaymentMethodVC {
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
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
        
    }
}
// MARK: - ...  Functions
extension PaymentMethodVC {
    func setup() {
        paymentTbl.delegate = self
        paymentTbl.dataSource = self
        paymentTbl.observe()
        paymentTbl.skeleton()
        viewModel?.fetchpayments()
        doneBtn.publisher.listen(on: {[weak self] _ in
            if self?.methodId == 0 {
                self?.didError(error: "Choose a payment method".localized)
                return
            }
            self?.delegate?.done(paymentId: self?.methodId ?? 0)
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
        if UD.club != nil {
            doneBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            paymentTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no packages available".localized)
        }else {
            paymentTbl.isHidden = false
            hideEmptyScreen()
        }
        paymentTbl.reloadData()
        paymentTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension PaymentMethodVC {
}
extension PaymentMethodVC:UITableViewDelegate , UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource()?.count ?? 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: PaymentmethodTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.id = methodId
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        methodId = viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0
        paymentTbl.reloadData()
    }

}
