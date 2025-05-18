//
//  NotificationVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NotificationVC: BaseController,Reloader {
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var notHight: NSLayoutConstraint!
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var notTbl: UITableView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var notLbl: UILabel!
    @IBOutlet weak var notView: UIView!
    var viewModel: NotificationViewModel?
    var coordinator: NotificationCoordinator?
}

// MARK: - ...  LifeCycle
extension NotificationVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
            self?.stopSwipeTop()
            self?.reload()
        })
        viewModel?.deltedata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchnotifications()
            
        })
    }
}
// MARK: - ...  Functions
extension NotificationVC {
    func setup() {
        notTbl.skeleton()
        notTbl.delegate = self
        notTbl.dataSource = self
        notTbl.observe()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchnotifications()
        deleteView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.deletenotification()
        }).store(self)
        swipeTopRefresh(scrollView: notTbl) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchnotifications()
        }
    }
    func reload() {
        notLbl.text = viewModel?.total.value ?? ""
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            notTbl.isHidden = true
            noResultView.isHidden = false
            notHight.constant = 0
            notView.isHidden = true
        } else {
            noResultView.isHidden = true
            notHight.constant = 41
            notView.isHidden = false
            notTbl.isHidden = false
        }
        notTbl.skeleton()
        notTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension NotificationVC {
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == notTbl {
            let tableViewVisibleHeight = notTbl.bounds.size.height
               let tableViewContentHeight = notTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && notTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchnotifications()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == notTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchnotifications()
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
        var cell = tableView.cell(type: NotsTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension NotificationVC : NotsTableViewCellDelegate {
    func click(wasPressedOnCell cell: NotsTableViewCell, model: Notificationdata) {
        if model.type ?? "" == "reservation" {
            coordinator?.detailsreservation(id: model.itemID ?? 0)
        }else if model.type ?? "" == "complaint" {
            coordinator?.complains()
        }
    }
    
    
}
