//
//  ReservationVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReservationVC: BaseController {
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var orderTbl: UITableView!
    @IBOutlet weak var perviousLineView: UIView!
    @IBOutlet weak var perviousLbl: UILabel!
    @IBOutlet weak var perviousView: UIView!
    @IBOutlet weak var ongoingLineView: UIView!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var ongoingView: UIView!
    @IBOutlet weak var newLineView: UIView!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var newView: UIView!
    var viewModel: ReservationViewModel?
    var coordinator: ReservationCoordinator?
}

// MARK: - ...  LifeCycle
extension ReservationVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
        Constants.index = 0
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
extension ReservationVC {
    func setup() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        orderTbl.skeleton()
        orderTbl.delegate = self
        orderTbl.dataSource = self
        orderTbl.observe()
        if newLineView.backgroundColor == R.color.normalblue() {
            viewModel?.status.send(2)
        }else if ongoingLineView.backgroundColor == R.color.normalblue() {
            viewModel?.status.send(3)
        }else if perviousLineView.backgroundColor == R.color.normalblue() {
            viewModel?.status.send(4)
        }
        if viewModel?.status.value ?? 0 == 2 {
            newLbl.textColor = R.color.normalblue()
            newLineView.backgroundColor = R.color.normalblue()
            ongoingLbl.textColor = R.color.black2()
            ongoingLineView.backgroundColor = R.color.black2()
            perviousLbl.textColor = R.color.black2()
            perviousLineView.backgroundColor = R.color.black2()
        }else  if viewModel?.status.value ?? 0 == 3 {
            ongoingLbl.textColor = R.color.normalblue()
            ongoingLineView.backgroundColor = R.color.normalblue()
            perviousLbl.textColor = R.color.black2()
            perviousLineView.backgroundColor = R.color.black2()
            newLbl.textColor = R.color.black2()
            newLineView.backgroundColor = R.color.black2()
        }else  if viewModel?.status.value ?? 0 == 4 {
            perviousLbl.textColor = R.color.normalblue()
            perviousLineView.backgroundColor = R.color.normalblue()
            ongoingLbl.textColor = R.color.black2()
            ongoingLineView.backgroundColor = R.color.black2()
            newLbl.textColor = R.color.black2()
            newLineView.backgroundColor = R.color.black2()
        }
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchorders()
        newView.publisherGesture.listen(on: {[weak self] _ in
            if self?.viewModel?.status.value ?? 0 == 2 {
                return
            }
            self?.viewModel?.status.send(2)
            self?.newLbl.textColor = R.color.normalblue()
            self?.newLineView.backgroundColor = R.color.normalblue()
            self?.ongoingLbl.textColor = R.color.black2()
            self?.ongoingLineView.backgroundColor = R.color.black2()
            self?.perviousLbl.textColor = R.color.black2()
            self?.perviousLineView.backgroundColor = R.color.black2()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchorders()
        }).store(self)
        ongoingView.publisherGesture.listen(on: {[weak self] _ in
            if self?.viewModel?.status.value ?? 0 == 3 {
                return
            }
            self?.viewModel?.status.send(3)
            self?.newLbl.textColor = R.color.black2()
            self?.newLineView.backgroundColor = R.color.black2()
            self?.ongoingLbl.textColor = R.color.normalblue()
            self?.ongoingLineView.backgroundColor = R.color.normalblue()
            self?.perviousLbl.textColor = R.color.black2()
            self?.perviousLineView.backgroundColor = R.color.black2()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchorders()
        }).store(self)
        perviousView.publisherGesture.listen(on: {[weak self] _ in
            if self?.viewModel?.status.value ?? 0 == 4 {
                return
            }
            self?.viewModel?.status.send(4)
            self?.newLbl.textColor = R.color.black2()
            self?.newLineView.backgroundColor = R.color.black2()
            self?.ongoingLbl.textColor = R.color.black2()
            self?.ongoingLineView.backgroundColor = R.color.black2()
            self?.perviousLbl.textColor = R.color.normalblue()
            self?.perviousLineView.backgroundColor = R.color.normalblue()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchorders()
        }).store(self)
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            orderTbl.isHidden = true
            noDataView.isHidden = false
        } else {
            orderTbl.isHidden = false
            noDataView.isHidden = true
        }
        orderTbl.skeleton()
        orderTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension ReservationVC {
}
extension ReservationVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == orderTbl {
            let tableViewVisibleHeight = orderTbl.bounds.size.height
               let tableViewContentHeight = orderTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && orderTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchorders()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == orderTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchorders()
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
        var cell = tableView.cell(type: ReservationTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.detailsorder(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
    }
    
}
