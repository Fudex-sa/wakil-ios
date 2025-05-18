//
//  ClientRatingVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ClientRatingVC: BaseController,Reloader {
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var ratingTbl: UITableView!
    var viewModel: ClientRatingViewModel?
    var coordinator: ClientRatingCoordinator?
    var centerId = 0
}

// MARK: - ...  LifeCycle
extension ClientRatingVC {
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
            self?.stopSwipeTop()
            self?.reload()
        })
    }
}
// MARK: - ...  Functions
extension ClientRatingVC {
    func setup() {
        viewModel?.centerId.send(centerId)
        ratingTbl.skeleton()
        ratingTbl.delegate = self
        ratingTbl.dataSource = self
        ratingTbl.observe()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchrating()
        swipeTopRefresh(scrollView: ratingTbl) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchrating()
        }
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            ratingTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Rating list is empty".localized)
            
        } else {
            hideEmptyScreen()
            ratingTbl.isHidden = false
        }
        ratingTbl.skeleton()
        ratingTbl.stopSwipeButtom()
        
    }
}
// MARK: - ...  View Contract
extension ClientRatingVC {
}
extension ClientRatingVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == ratingTbl {
            let tableViewVisibleHeight = ratingTbl.bounds.size.height
               let tableViewContentHeight = ratingTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && ratingTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchrating()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == ratingTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchrating()
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
        var cell = tableView.cell(type: RatingTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
