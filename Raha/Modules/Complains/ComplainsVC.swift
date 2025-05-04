//
//  ComplainsVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ComplainsVC: BaseController {
    @IBOutlet weak var closedLbl: UILabel!
    @IBOutlet weak var processLbl: UILabel!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var allLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var scrollContainerView: UIScrollView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var complainTbl: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    var viewModel: ComplainsViewModel?
    var coordinator: ComplainsCoordinator?
}

// MARK: - ...  LifeCycle
extension ComplainsVC {
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
        subscribe()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        unsubscribe()
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
extension ComplainsVC {
    func setup() {
        scrollContainerView.delegate = self
        complainTbl.skeleton()
        complainTbl.delegate = self
        complainTbl.dataSource = self
        complainTbl.observe()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchcomplains()
        sendBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.sendcomplain()
        }).store(self)
        filterBtn.publisher.listen(on: {[weak self] _ in
            if self?.statusView.isHidden == false {
                self?.statusView.fadeOut()
                self?.statusView.isHidden = true
                return
            }
            self?.statusView.fadeIn()
            self?.statusView.isHidden = false
            self?.status()
        }).store(self)
        allLbl.UIViewAction { [self] in
            statusView.fadeOut()
            statusView.isHidden = true
            viewModel?.status.send(0)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchcomplains()
        }
        newLbl.UIViewAction { [self] in
            statusView.fadeOut()
            statusView.isHidden = true
            viewModel?.status.send(1)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchcomplains()
        }
        processLbl.UIViewAction { [self] in
            statusView.fadeOut()
            statusView.isHidden = true
            viewModel?.status.send(2)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchcomplains()
        }
        closedLbl.UIViewAction { [self] in
            statusView.fadeOut()
            statusView.isHidden = true
            viewModel?.status.send(3)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchcomplains()
        }
    }
    func status() {
        if viewModel?.status.value ?? 0 == 0 {
            allLbl.textColor = R.color.black1()
            newLbl.textColor = R.color.black3()
            processLbl.textColor = R.color.black3()
            closedLbl.textColor = R.color.black3()
        }else  if viewModel?.status.value ?? 0 == 1 {
            allLbl.textColor = R.color.black3()
            newLbl.textColor = R.color.black1()
            processLbl.textColor = R.color.black3()
            closedLbl.textColor = R.color.black3()
        }else  if viewModel?.status.value ?? 0 == 2 {
            allLbl.textColor = R.color.black3()
            newLbl.textColor = R.color.black3()
            processLbl.textColor = R.color.black1()
            closedLbl.textColor = R.color.black3()
        }else  if viewModel?.status.value ?? 0 == 3 {
            allLbl.textColor = R.color.black3()
            newLbl.textColor = R.color.black3()
            processLbl.textColor = R.color.black3()
            closedLbl.textColor = R.color.black1()
        }
        //statusView.isHidden = true
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            complainTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Complaints & Suggestions list is empty".localized)
            
        } else {
            hideEmptyScreen()
            complainTbl.isHidden = false
        }
        complainTbl.skeleton()
        complainTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension ComplainsVC {
}
extension ComplainsVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainerView {
            let tableViewVisibleHeight = scrollContainerView.bounds.size.height
               let tableViewContentHeight = scrollContainerView.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollContainerView.contentOffset.y > tableViewOffsetThreshold && scrollContainerView.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchcomplains()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == scrollContainerView {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchcomplains()
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
        var cell = tableView.cell(type: ComplainTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension ComplainsVC: NotificationSubscriber {
    func notificationControlWillPresent(notificationType: String?, json: String, closure: SoundHandler?) {
        closure?(true)
        if notificationType ?? "" == "complaint"  {
            return
        }
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchcomplains()
    }
}
