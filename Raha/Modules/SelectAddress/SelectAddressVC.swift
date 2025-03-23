//
//  SelectAddressVC.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol SelectAddressVCDelegate: AnyObject {
    func done(model : AddressesDatum)

}
// MARK: - ...  ViewController - Vars
class SelectAddressVC: BaseController {
    @IBOutlet weak var addressTbl: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addView: UIView!
    var viewModel: SelectAddressViewModel?
    var coordinator: SelectAddressCoordinator?
    var addressId = 0
    var addressdata: AddressesDatum?
    var delegate: SelectAddressVCDelegate?
}

// MARK: - ...  LifeCycle
extension SelectAddressVC {
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
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension SelectAddressVC {
    func setup() {
        addressTbl.skeleton()
        addressTbl.delegate = self
        addressTbl.dataSource = self
        addressTbl.observe()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchaddresses()
        addView.publisherGesture.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: {
                guard let scene = R.storyboard.addAddressStoryboard.addAddressVC() else { return }
                let view = UIApplication.topViewController() as? BaseController
               view?.push(scene)
               
            })
            }).store(self)
        doneBtn.publisher.listen(on: {[weak self] _ in
            for index in self?.viewModel?.items.value ?? [] {
                if index.id == self?.addressId ?? 0 {
                    self?.addressdata = index
                }
            }
            self?.delegate?.done(model: (self?.addressdata!)!)
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            addressTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Addresses list is empty".localized)
            
        } else {
            hideEmptyScreen()
            addressTbl.isHidden = false
        }
        addressTbl.skeleton()
        addressTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension SelectAddressVC {
}
extension SelectAddressVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == addressTbl {
            let tableViewVisibleHeight = addressTbl.bounds.size.height
               let tableViewContentHeight = addressTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && addressTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchaddresses()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == addressTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchaddresses()
                } else {
                    scrollView.stopSwipeButtom()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource()?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: AddressTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.id = addressId
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
  

extension SelectAddressVC :AddressTableViewCellViewCellDelegate {
    func done(wasPressedOnCell cell: AddressTableViewCell , model : AddressesDatum) {
        addressId = model.id ?? 0
        addressTbl.reloadData()
    }
}
