//
//  ChangeClubVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
protocol ChangeClubVCDelegate: AnyObject {
    func done()
}
// MARK: - ...  ViewController - Vars
class ChangeClubVC: BaseController {
    @IBOutlet weak var clubsTbl: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    var viewModel: ChangeClubViewModel?
    var coordinator: ChangeClubCoordinator?
    weak var delegate: ChangeClubVCDelegate?
}

// MARK: - ...  LifeCycle
extension ChangeClubVC {
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
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
    }
}
// MARK: - ...  Functions
extension ChangeClubVC {
    func setup() {
        clubsTbl.delegate = self
        clubsTbl.dataSource = self
        viewModel?.countryId.send(1)
        clubsTbl.observe()
        clubsTbl.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchclubs()
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            clubsTbl.isHidden = true
            showEmptyScreen(for: 250 , title: "There are no clubs available".localized)
        }else {
            clubsTbl.isHidden = false
            hideEmptyScreen()
        }
        clubsTbl.reloadData()
        clubsTbl.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension ChangeClubVC {
}
extension ChangeClubVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == clubsTbl {
            let tableViewVisibleHeight = clubsTbl.bounds.size.height
               let tableViewContentHeight = clubsTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && clubsTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchclubs()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == clubsTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchclubs()
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
        var cell = tableView.cell(type: SelectclubTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        UD.club = viewModel?.dataSource()?[safe: indexPath.row]
        delegate?.done()
        dismiss(animated: true, completion: nil)
    }

}
