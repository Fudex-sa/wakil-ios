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
