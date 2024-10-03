//
//  NotificationVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NotificationVC: BaseController , Reloader{
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var notTbl: UITableView!
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
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = true
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
            self?.stopSwipeTop()
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension NotificationVC {
    func setup() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        notTbl.delegate = self
        notTbl.dataSource = self
        notTbl.observe()
        notTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchnotifications()
        viewModel?.readallnotification()
        swipeTopRefresh(scrollView: notTbl) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchnotifications()
        }
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            notTbl.isHidden = true
            showEmptyScreen(for: 250 , title: "There are no notifications available".localized)
        }else {
            notTbl.isHidden = false
            hideEmptyScreen()
        }
        notTbl.reloadData()
        notTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension NotificationVC {
}
extension NotificationVC:UITableViewDelegate , UITableViewDataSource {
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
        var cell = tableView.cell(type: NotificationTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "news" {
            coordinator?.notdetails(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "likePost"{
            coordinator?.detailsposts(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "commentPost"{
            coordinator?.comments(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "likePostComment"{
            coordinator?.comments(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "replyPost"{
            coordinator?.reply(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "likeBackstageComment"{
            coordinator?.detailsbackstages(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }else  if viewModel?.dataSource()?[safe: indexPath.row]?.notificationType ?? "" == "replyBackstage"{
            coordinator?.reply(id: viewModel?.dataSource()?[safe: indexPath.row]?.itemId ?? 0)
           
        }
       
    }

}
