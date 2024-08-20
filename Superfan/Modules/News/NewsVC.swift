//
//  NewsVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NewsVC: BaseController {
    @IBOutlet weak var newsTbl: UITableView!
    var viewModel: NewsViewModel?
    var coordinator: NewsCoordinator?
}

// MARK: - ...  LifeCycle
extension NewsVC {
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
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension NewsVC {
    func setup() {
        newsTbl.delegate = self
        newsTbl.dataSource = self
        viewModel?.countryId.send(1)
        newsTbl.observe()
        newsTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchnews()
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            newsTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no news available".localized)
        }else {
            newsTbl.isHidden = false
            hideEmptyScreen()
        }
        newsTbl.reloadData()
        newsTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension NewsVC {
}
extension NewsVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == newsTbl {
            let tableViewVisibleHeight = newsTbl.bounds.size.height
               let tableViewContentHeight = newsTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && newsTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchnews()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == newsTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchnews()
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
        var cell = tableView.cell(type: NewsTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        self.coordinator?.detailsnews(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
    }

}

extension NewsVC : NewsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: NewsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
