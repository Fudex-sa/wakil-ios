//
//  SubscriptionsVC.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SubscriptionsVC: BaseController {
    @IBOutlet weak var scrollContainerView: UIScrollView!
    @IBOutlet weak var subcribeTbl: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var packagesTbl: UITableView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubView: UIView!
    @IBOutlet weak var subscribeView: UIView!
    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var packageBtn: UIButton!
    var viewModel: SubscriptionsViewModel?
    var coordinator: SubscriptionsCoordinator?
    var type = 0
    var clubId = 0
    var club: SelectclubDatum?
    var payTaps: PayTaps?

}

// MARK: - ...  LifeCycle
extension SubscriptionsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        if UD.club != nil {
            clubId = UD.club?.id ?? 0
            club = UD.club
        }
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
        viewModel?.paymentdata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.payTaps = .init(dataSource: self)
            self?.payTaps?.delegate = self
            self?.payTaps?.present(in: self)
        })
        
    }
}
// MARK: - ...  Functions
extension SubscriptionsVC {
    func setup() {
        scrollContainerView.delegate = self
        packagesTbl.delegate = self
        packagesTbl.dataSource = self
        packagesTbl.observe()
        packagesTbl.skeleton()
        clickBtn()
        packageBtn.publisher.listen(on: {[weak self] _ in
            if self?.type != 0 {
                self?.type = 0
                self?.clickBtn()
            }
        }).store(self)
        subscribeBtn.publisher.listen(on: {[weak self] _ in
            if self?.type != 1 {
                self?.type = 1
                self?.clickBtn()
            }
        }).store(self)
        clubView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.changeclub()
        }).store(self)
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            packagesTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no packages available".localized)
        }else {
            packagesTbl.isHidden = false
            hideEmptyScreen()
        }
        packagesTbl.reloadData()
        packagesTbl.stopSwipeButtom()

    }
    func clickBtn(){
        viewModel?.clubId.send(clubId)
        clubLbl.text = club?.name ?? ""
        clubImg.setImage(url: club?.photo ?? "")
        if type == 0 {
            packageBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            subscribeBtn.backgroundColor = R.color.whiteColor()
            packageBtn.borderColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            packageBtn.borderWidth = 1
            subscribeBtn.borderColor = R.color.lightgray1()
            subscribeBtn.borderWidth = 1
            packageBtn.setTitleColor(R.color.whiteColor(), for: .normal)
            subscribeBtn.setTitleColor(R.color.gray1(), for: .normal)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchpackages()
            packageView.isHidden = false
            subscribeView.isHidden = true
        }else {
            subscribeBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            packageBtn.backgroundColor = R.color.whiteColor()
            subscribeBtn.borderColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            subscribeBtn.borderWidth = 1
            packageBtn.borderColor = R.color.lightgray1()
            packageBtn.borderWidth = 1
            subscribeBtn.setTitleColor(R.color.whiteColor(), for: .normal)
            packageBtn.setTitleColor(R.color.gray1(), for: .normal)
            packageView.isHidden = true
            subscribeView.isHidden = false
        }
    }
}
// MARK: - ...  View Contract
extension SubscriptionsVC {
}
extension SubscriptionsVC:UITableViewDelegate , UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainerView {
            let tableViewVisibleHeight = scrollContainerView.bounds.size.height
               let tableViewContentHeight = scrollContainerView.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && scrollContainerView.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchpackages()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == scrollContainerView {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchpackages()
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
        var cell = tableView.cell(type: PackagesTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        cell.clubId = clubId
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        if tableView == packagesTbl {
            viewModel?.packageId.send(viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
            coordinator?.paymentmethod()
        }
        
    }

}
extension SubscriptionsVC: PayTapsDelegate, PayTapsDataSource {
    func payTaps(_ payTaps: PayTaps?, didPay orderID: Int) {
        coordinator?.paymentdone()
    }
    func payTaps(_ payTaps: PayTaps?, cancel pay: Bool) {
        NotificationBuilder().setTitle("Info".localized).setBody("You are cancelled the payment process".localized).setTheme(.info).bulid()
    }
    func payTaps(_ payTaps: PayTaps?, fail pay: Bool) {
        super.didError(error: "Online payment has been made a mistake please try again".localized)
    }
    
    func payTaps(_ payTaps: PayTaps?, successURL: Bool?) -> String? {
        return "success"
    }
    
    func payTaps(_ payTaps: PayTaps?, failURL: Bool?) -> String? {
        return "failed"
    }
    
    func payTaps(_ payTaps: PayTaps?, URL: Bool?) -> String? {
        return viewModel?.paymentdata.value?.data?.invoiceURL ?? ""
    }
}
