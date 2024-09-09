//
//  MypostsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MypostsVC: BaseController {
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    var viewModel: MypostsViewModel?
    var coordinator: MypostsCoordinator?
}

// MARK: - ...  LifeCycle
extension MypostsVC {
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
extension MypostsVC {
    func setup() {
        postsTbl.delegate = self
        postsTbl.dataSource = self
        postsTbl.observe()
        postsTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchposts()
        addBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.addpost()
        }).store(self)
        if UD.club != nil {
            addBtn.setTitleColor(UIColor(hex: UD.club?.color ?? ""), for: .normal)
        }
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            postsTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no posts available".localized)
        }else {
            postsTbl.isHidden = false
            hideEmptyScreen()
        }
        postsTbl.reloadData()
        postsTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension MypostsVC {
}
extension MypostsVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == postsTbl {
            let tableViewVisibleHeight = postsTbl.bounds.size.height
               let tableViewContentHeight = postsTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && postsTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchposts()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == postsTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchposts()
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
        var cell = tableView.cell(type: PostsTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        self.coordinator?.detailsposts(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
    }

}
extension MypostsVC : PostsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: PostsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
