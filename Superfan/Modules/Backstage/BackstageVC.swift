//
//  BackstageVC.swift
//  Superfan
//
//  Created by ADAM on 12/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class BackstageVC: BaseController , Reloader{
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var backstageTbl: UITableView!
    var viewModel: BackstageViewModel?
    var coordinator: BackstageCoordinator?
    var expandedStates = [Bool]()
}

// MARK: - ...  LifeCycle
extension BackstageVC {
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
extension BackstageVC {
    func setup() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        backstageTbl.delegate = self
        backstageTbl.dataSource = self
        backstageTbl.observe()
        backstageTbl.skeleton()
        expandedStates.removeAll()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchbackstage()
        swipeTopRefresh(scrollView: backstageTbl) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchbackstage()
        }
    }
    func reload(){
        let postCount = viewModel?.items.value?.count ?? 0
           if expandedStates.count != postCount {
               expandedStates = Array(repeating: false, count: postCount)
           }
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            backstageTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no backstages available".localized)
        }else {
            backstageTbl.isHidden = false
            hideEmptyScreen()
        }
        self.expandedStates.append(contentsOf: [Bool](repeating: false, count: viewModel?.items.value?.count ?? 0))
        backstageTbl.reloadData()
        backstageTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension BackstageVC {
}
extension BackstageVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == backstageTbl {
            let tableViewVisibleHeight = backstageTbl.bounds.size.height
               let tableViewContentHeight = backstageTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && backstageTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchbackstage()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == backstageTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchbackstage()
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
            cell.configure(with: text, isExpanded: isExpanded) { [self] in
                if viewModel?.dataSource()?[safe: indexPath.row]?.is_subscriped ?? 1 == 0 {
                    Coordinator.instance.suscribpopup()
                    return
                }
                self.expandedStates[indexPath.item] = !self.expandedStates[indexPath.item]
                self.backstageTbl.reloadRows(at: [indexPath], with: .automatic)
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
        if viewModel?.dataSource()?[safe: indexPath.row]?.is_subscriped ?? 1 == 0 {
            Coordinator.instance.suscribpopup()
            return
        }
        self.coordinator?.detailsposts(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
    }

}
extension BackstageVC : PostsTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: PostsTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
    func favoraite(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
        }else {
            if model.is_subscriped ?? 1 == 0 {
                Coordinator.instance.suscribpopup()
                return
            }
            startLoading()
            viewModel?.postId.send(model.id ?? 0)
            if model.is_liked == 1 {
                viewModel?.unlikebackstage()
            }else {
                viewModel?.likebackstage()
            }
        }
    }
    func comments(wasPressedOnCell cell: PostsTableViewCell, model: PostsDatum) {
        if model.is_subscriped ?? 1 == 0 {
            Coordinator.instance.suscribpopup()
            return
        }
        coordinator?.comments(id: model.id ?? 0)
    }
}
