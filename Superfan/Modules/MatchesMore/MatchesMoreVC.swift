//
//  MatchesMoreVC.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MatchesMoreVC: BaseController ,Reloader{
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var matchesTbl: UITableView!
    @IBOutlet weak var perviousLineView: UIView!
    @IBOutlet weak var perviousLbl: UILabel!
    @IBOutlet weak var perviousView: UIView!
    @IBOutlet weak var todayLineView: UIView!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var todayView: UIView!
    var viewModel: MatchesMoreViewModel?
    var coordinator: MatchesMoreCoordinator?
    var type = 0
}

// MARK: - ...  LifeCycle
extension MatchesMoreVC {
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
extension MatchesMoreVC {
    func setup() {
        matchesTbl.delegate = self
        matchesTbl.dataSource = self
        matchesTbl.delegate = self
        matchesTbl.dataSource = self
        if type == 0 {
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchtodaymatch()
            todayLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            todayLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            todayLineView.isHidden = false
            perviousLbl.textColor = UIColor(hex: "#353535")
            perviousLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            perviousLineView.isHidden = true
        }else {
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchperviousymatch()
            perviousLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            perviousLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            perviousLineView.isHidden = false
            todayLbl.textColor = UIColor(hex: "#353535")
            todayLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            todayLineView.isHidden = true
        }
        todayView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 0 {
                self?.todayLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.todayLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.todayLineView.isHidden = false
                self?.perviousLbl.textColor = UIColor(hex: "#353535")
                self?.perviousLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.perviousLineView.isHidden = true
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchtodaymatch()
                self?.type = 0
            }
        }).store(self)
        perviousView.publisherGesture.listen(on: {[weak self] _ in
            if self?.type != 1 {
                self?.perviousLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.perviousLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.perviousLineView.isHidden = false
                self?.todayLbl.textColor = UIColor(hex: "#353535")
                self?.todayLineView.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
                self?.todayLineView.isHidden = true
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchperviousymatch()
                self?.type = 1
            }
        }).store(self)
        swipeTopRefresh(scrollView: matchesTbl) { [weak self] in
            if self?.type == 0 {
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchtodaymatch()
            }else {
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchperviousymatch()
            }
        }
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            matchesTbl.isHidden = true
            showEmptyScreen(for: 350 , title: "There are no matches available".localized)
        }else {
            matchesTbl.isHidden = false
            hideEmptyScreen()
        }
        matchesTbl.reloadData()
        matchesTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension MatchesMoreVC {
}
extension MatchesMoreVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == matchesTbl {
        let tableViewVisibleHeight = matchesTbl.bounds.size.height
           let tableViewContentHeight = matchesTbl.contentSize.height
           let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
           
        if scrollView.contentOffset.y > tableViewOffsetThreshold && matchesTbl.isDragging {
            // Fetch more data here
            if case self.viewModel?.canPaginate() = true {
                if self.type == 0 {
                    self.viewModel?.fetchtodaymatch()
                }else {
                    self.viewModel?.fetchperviousymatch()
                }
            }
        }
    }
}
func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if scrollView == matchesTbl {
        scrollView.swipeButtomRefresh { [weak self] in
            if case self?.viewModel?.canPaginate() = true {
                if self?.type == 0 {
                    self?.viewModel?.fetchtodaymatch()
                }else {
                    self?.viewModel?.fetchperviousymatch()
                }
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
        var cell = tableView.cell(type: MatchesTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        coordinator?.detailsmatchs(id: viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
       
    }

}
extension MatchesMoreVC : MatchesTableViewCellDelegate{
    func clubdetails(wasPressedOnCell cell: MatchesTableViewCell, clubId: Int) {
        coordinator?.detailsclub(id: clubId)
    }
}
extension MatchesMoreVC: NotificationSubscriber {
    func notificationControlWillPresent(notificationType: String?, json: String, closure: SoundHandler?) {
        closure?(true)
        if notificationType ?? "" != "match_events" {
            return
        }
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        if type == 0 {
            viewModel?.fetchtodaymatch()
        }else {
            viewModel?.fetchperviousymatch()
        }
    }
}
