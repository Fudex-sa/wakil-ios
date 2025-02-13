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
class MypostsVC: BaseController , Reloader{
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    var viewModel: MypostsViewModel?
    var coordinator: MypostsCoordinator?
    var expandedStates = [Bool]()
    var ismypost = true
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
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
        Constants.index = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        expandedStates.removeAll()
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
        viewModel?.likedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.likedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
        })
       
    }
}
// MARK: - ...  Functions
extension MypostsVC {
    func setup() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        postsTbl.delegate = self
        postsTbl.dataSource = self
        postsTbl.observe()
        postsTbl.skeleton()
        expandedStates.removeAll()
        if ismypost == false {
            addBtn.isHidden = true
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchposts1()
            titleLbl.text = "Posts".localized
        }else {
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchposts()
        }
        addBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.addpost()
        }).store(self)
//        if UD.club != nil {
//            addBtn.setTitleColor(UIColor(hex: UD.club?.color ?? ""), for: .normal)
//        }
        swipeTopRefresh(scrollView: postsTbl) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchposts()
        }
    }
    func reload(){
        let postCount = viewModel?.items.value?.count ?? 0
           if expandedStates.count != postCount {
               expandedStates = Array(repeating: false, count: postCount)
           }
        if viewModel?.items.value?.count ?? 0 == 0 {
            postsTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no posts available".localized)
        }else {
            postsTbl.isHidden = false
            hideEmptyScreen()
        }
        self.expandedStates.append(contentsOf: [Bool](repeating: false, count: viewModel?.items.value?.count ?? 0))
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
        if expandedStates.count != 0 {
            let isExpanded = expandedStates[indexPath.item]
            let text = viewModel?.items.value?[safe: indexPath.row]?.description ?? ""
            cell.configure(with: text, isExpanded: isExpanded) {
                self.expandedStates[indexPath.item] = !self.expandedStates[indexPath.item]
                self.postsTbl.reloadRows(at: [indexPath], with: .automatic)
            }
        }
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
    func favoraite(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
        }else {
            startLoading()
            viewModel?.postId.send(model.id ?? 0)
            if model.is_liked == 1 {
                viewModel?.unlikepost()
            }else {
                viewModel?.likepost()
            }
        }
    }
    func comments(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        coordinator?.comments(id: model.id ?? 0)
    }
}
