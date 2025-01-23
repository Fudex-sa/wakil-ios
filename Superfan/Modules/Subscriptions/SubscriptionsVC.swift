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
    @IBOutlet weak var searchTxf: UITextField!
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
    @IBOutlet weak var confirmeBtn: UIButton!
    var viewModel: SubscriptionsViewModel?
    var coordinator: SubscriptionsCoordinator?
    var type = 0
    var clubId = 0
    var club: SelectclubDatum?
    var payTaps: PayTaps?
    var timer: TimeHelper?
    var suucesUrl = ""
    var failedurl = ""

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
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
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
            if self?.type == 1 {
                return
            }
            self?.reload()
        })
        viewModel?.mysubscribedata.listen(on: { [weak self] value in
            if self?.type == 0 {
                return
            }
            self?.reloadsubscribe()
        })
        viewModel?.paymentdata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.suucesUrl = self?.viewModel?.paymentdata.value?.data?.successLink ?? ""
            self?.failedurl = self?.viewModel?.paymentdata.value?.data?.errorLink ?? ""
            self?.viewModel?.checkclubId.send(0)
            self?.payTaps = .init(dataSource: self)
            self?.payTaps?.delegate = self
            self?.payTaps?.present(in: self)
        })
        viewModel?.delete.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.delete.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.viewModel?.mysubscribe.send([])
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchmypackages()
        })
        viewModel?.checksubscribe.listen(on: { [weak self] value in
            self?.stopLoading()
            if self?.viewModel?.checksubscribe.value?.status == true {
                self?.stopLoading()
                self?.viewModel?.subscribe()
//                self?.coordinator?.paymentmethod()
            }else {
                self?.coordinator?.checksubscribe()
            }
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
        subcribeTbl.delegate = self
        subcribeTbl.dataSource = self
        subcribeTbl.observe()
        subcribeTbl.skeleton()
        clickBtn()
        packageBtn.publisher.listen(on: {[weak self] _ in
            if self?.type != 0 {
                self?.type = 0
                self?.viewModel?.duration.send("")
                self?.viewModel?.price.send("")
                self?.searchTxf.text = ""
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
        confirmeBtn.publisher.listen(on: {[weak self] _ in
            if self?.viewModel?.packageId.value ?? 0 == 0 {
                self?.didError(error: "select package first".localized)
                return
            }
            self?.startLoading()
            self?.viewModel?.fetchchecksubscribe()
        }).store(self)
        searchTxf.publisher.listen(on: { [weak self]_ in
            self?.timer?.stopTimer()
            self?.timer = nil
            self?.timer = .init(seconds: 1, closure: { [self] (second) in
                self?.timer?.stopTimer()
                self?.timer = nil
                self?.viewModel?.keyword.send(self?.searchTxf.text ?? "")
                self?.viewModel?.mysubscribe.send([])
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchmypackages()
            })
            
        }).store(self)
        filterBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.filter()
        }).store(self)
    }
    func reload(){
        hideEmptyScreen()
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
    func reloadsubscribe(){
        hideEmptyScreen()
        if viewModel?.mysubscribe.value?.count ?? 0 == 0 {
            subcribeTbl.isHidden = true
            showEmptyScreen(for: 400 , title: "There are no Subscription available".localized)
        }else {
            subcribeTbl.isHidden = false
            hideEmptyScreen()
        }
        subcribeTbl.reloadData()
        subcribeTbl.stopSwipeButtom()

    }
    func clickBtn(){
        viewModel?.clubId.send(clubId)
        clubLbl.text = club?.name ?? ""
        clubImg.setImage(url: club?.photo ?? "")
        if type == 0 {
            packageBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            subscribeBtn.backgroundColor = R.color.textfileldbackground()
            packageBtn.borderColor = .clear
            packageBtn.borderWidth = 0
            subscribeBtn.borderColor = .clear
            subscribeBtn.borderWidth = 0
            packageBtn.setTitleColor(R.color.whiteColor(), for: .normal)
            subscribeBtn.setTitleColor(R.color.gray1(), for: .normal)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchpackages()
            packageView.isHidden = false
            subscribeView.isHidden = true
            confirmeBtn.isHidden = false
        }else {
            subscribeBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "#E51D35")
            packageBtn.backgroundColor = R.color.textfileldbackground()
            packageBtn.borderColor = .clear
            packageBtn.borderWidth = 0
            subscribeBtn.borderColor = .clear
            subscribeBtn.borderWidth = 0
            subscribeBtn.setTitleColor(R.color.whiteColor(), for: .normal)
            packageBtn.setTitleColor(R.color.gray1(), for: .normal)
            packageView.isHidden = true
            subscribeView.isHidden = false
            confirmeBtn.isHidden = true
            viewModel?.mysubscribe.send([])
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchmypackages()
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
                    if self.type == 0 {
                        self.viewModel?.fetchpackages()
                    }else {
                        self.viewModel?.fetchmypackages()
                    }
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == scrollContainerView {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    if self?.type == 0 {
                        self?.viewModel?.fetchpackages()
                    }else {
                        self?.viewModel?.fetchmypackages()
                    }
                } else {
                    scrollView.stopSwipeButtom()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == packagesTbl {
            return viewModel?.dataSource()?.count ?? 2
        }else {
            return viewModel?.mysubscribe.value?.count ?? 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == packagesTbl {
            var cell = tableView.cell(type: PackagesTableViewCell.self, indexPath)
            cell.model = viewModel?.dataSource()?[safe: indexPath.row]
            cell.clubId = clubId
            cell.packageId = viewModel?.packageId.value ?? 0
            cell.tax = viewModel?.tax.value ?? ""
            cell.setup()
            return cell
        }else {
            var cell = tableView.cell(type: PackagesTableViewCell.self, indexPath)
            cell.model = viewModel?.mysubscribe.value?[safe: indexPath.row]
            cell.setupmysubscribe()
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 && viewModel?.mysubscribe.value?.count ?? 0 == 0 {
            return
        }
        if tableView == packagesTbl {
            viewModel?.packageId.send(viewModel?.dataSource()?[safe: indexPath.row]?.id ?? 0)
            viewModel?.checkclubId.send(viewModel?.dataSource()?[safe: indexPath.row]?.club?.id ?? 0)
            packagesTbl.reloadData()
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
        return suucesUrl
    }
    
    func payTaps(_ payTaps: PayTaps?, failURL: Bool?) -> String? {
        return failedurl
    }
    
    func payTaps(_ payTaps: PayTaps?, URL: Bool?) -> String? {
        return viewModel?.paymentdata.value?.data?.invoiceURL ?? ""
    }
}

extension SubscriptionsVC : PackagesTableViewCellDelegate{
    func delete(wasPressedOnCell cell: PackagesTableViewCell, model: MysubscribeDatum) {
        viewModel?.packageId.send(model.id ?? 0)
        viewModel?.checkclubId.send(0)
        coordinator?.deletesubscribe()
    }
}
