//
//  DetailsreservationVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

// MARK: - ...  ViewController - Vars
class DetailsreservationVC: BaseController {
    @IBOutlet weak var vatCurrencyLbl: UILabel!
    @IBOutlet weak var vatImg: UIImageView!
    @IBOutlet weak var totalCurrencyLbl: UILabel!
    @IBOutlet weak var totalImg: UIImageView!
    @IBOutlet weak var serviceImg: UIImageView!
    @IBOutlet weak var serviceCurrencyLbl: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var cancelLbl: UILabel!
    @IBOutlet weak var cancelImg: UIImageView!
    @IBOutlet weak var refundView: UIView!
    @IBOutlet weak var cancelHight: NSLayoutConstraint!
    @IBOutlet weak var prividerImg: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var userRateLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var nameRateLbl: UILabel!
    @IBOutlet weak var userRateImg: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateSpaceView: UIView!
    @IBOutlet weak var suggestionBtn: UIButton!
    @IBOutlet weak var suggestionView: UIView!
    @IBOutlet weak var suggestionSpaceView: UIView!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameGiftLbl: UILabel!
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var giftSpaceView: UIView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var servicesTbl: UITableView!
    @IBOutlet weak var copyView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var vatTitleLbl: UILabel!
    @IBOutlet weak var vatLbl: UILabel!
    @IBOutlet weak var totalpriceLbl: UILabel!
    var viewModel: DetailsreservationViewModel?
    var coordinator: DetailsreservationCoordinator?
    var service: [Service] = []
    var orderId = 0
    var copy = ""
}

// MARK: - ...  LifeCycle
extension DetailsreservationVC {
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
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.orderdetails.listen(on: { [weak self] value in
            self?.reload()
        })
       
       
    }
}
// MARK: - ...  Functions
extension DetailsreservationVC {
    func setup() {
        if Localizer.current == .arabic {
            serviceImg.isHidden = false
            serviceCurrencyLbl.isHidden = true
            totalImg.isHidden = false
            totalCurrencyLbl.isHidden = true
            vatImg.isHidden = false
            vatCurrencyLbl.isHidden = true
        }else {
            serviceImg.isHidden = true
            serviceCurrencyLbl.isHidden = false
            totalImg.isHidden = true
            totalCurrencyLbl.isHidden = false
            vatImg.isHidden = true
            vatCurrencyLbl.isHidden = false
        }
        if UD.address != nil {
            viewModel?.lat.send(Double(UD.address?.lat ?? "0.0") ?? 0.0)
            viewModel?.lng.send(Double(UD.address?.lng ?? "0.0") ?? 0.0)
        }else {
            viewModel?.lat.send(UD.lat ?? 0.0)
            viewModel?.lng.send(UD.lng ?? 0.0)
        }
        viewModel?.orderId.send(orderId)
        startLoading()
        viewModel?.fetchorderdetails()
        servicesTbl.skeleton()
        servicesTbl.delegate = self
        servicesTbl.dataSource = self
        servicesTbl.observe()
        cancelBtn.publisher.listen(on: {[weak self] _ in
            if self?.viewModel?.orderdetails.value?.data?.statusKey ?? 0 == 2 {
                self?.coordinator?.cancelorder(id: self?.orderId ?? 0)
            }else if self?.viewModel?.orderdetails.value?.data?.statusKey ?? 0 == 4 {
                self?.coordinator?.rateorder(id: self?.orderId ?? 0)
            }
        }).store(self)
        suggestionBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.sendcomplain(id: self?.orderId ?? 0)
        }).store(self)
        copyView.publisherGesture.listen(on: {[weak self] _ in
            UIPasteboard.general.string = self?.copy ?? ""
            let progress = MBProgressHUD.showAdded(to: self?.view ?? UIView(), animated: true)
            progress.mode = .text
            progress.label.text = "COPIED!".localized
            progress.show(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                progress.hide(animated: true)
            }
        }).store(self)
    }
    func reload() {
        stopLoading()
        dateLbl.text = viewModel?.orderdetails.value?.data?.date ?? ""
        timeLbl.text = viewModel?.orderdetails.value?.data?.time ?? ""
        priceLbl.text = viewModel?.orderdetails.value?.data?.price ?? ""
        vatTitleLbl.text = "\("Vat".localized) \(viewModel?.orderdetails.value?.data?.vatRate ?? "") % :"
        vatLbl.text = viewModel?.orderdetails.value?.data?.vatPrice ?? ""
        totalpriceLbl.text = viewModel?.orderdetails.value?.data?.totalPrice ?? ""
        prividerImg.setImage(url: viewModel?.orderdetails.value?.data?.branch?.image ?? "")
        nameLbl.text = viewModel?.orderdetails.value?.data?.branch?.name ?? ""
        rateLbl.text = viewModel?.orderdetails.value?.data?.branch?.rate?.string ?? ""
        distanceLbl.text = viewModel?.orderdetails.value?.data?.branch?.distance ?? ""
        if viewModel?.orderdetails.value?.data?.isGift ?? 0 == 1 {
            giftView.isHidden = false
            nameGiftLbl.text = viewModel?.orderdetails.value?.data?.gift?.name ?? ""
            phoneLbl.text = viewModel?.orderdetails.value?.data?.gift?.mobile ?? ""
        }else {
            giftView.isHidden = true
        }
        if viewModel?.orderdetails.value?.data?.branch?.rate ?? 0 == 0 {
            rateLbl.isHidden = true
            starImg.isHidden = true
        }else {
            rateLbl.isHidden = false
            starImg.isHidden = false
        }
        if viewModel?.orderdetails.value?.data?.rating != nil {
            rateView.isHidden = false
            userRateImg.setImage(url: viewModel?.orderdetails.value?.data?.rating?.user?.avatarURL ?? "")
            nameRateLbl.text = viewModel?.orderdetails.value?.data?.rating?.user?.name ?? ""
            commentLbl.text = viewModel?.orderdetails.value?.data?.rating?.comment ?? ""
            userRateLbl.text = viewModel?.orderdetails.value?.data?.rating?.rating?.string ?? ""

        }else {
            rateView.isHidden = true
        }
        if viewModel?.orderdetails.value?.data?.statusKey ?? 0 == 2 {
            cancelBtn.setTitle("Cancel order".localized, for: .normal)
            cancelView.isHidden = false
            cancelHight.constant = 92
            suggestionView.isHidden = false
            refundView.isHidden = true
        }else if viewModel?.orderdetails.value?.data?.statusKey ?? 0 == 4 && viewModel?.orderdetails.value?.data?.rating == nil {
            cancelBtn.setTitle("Service Evaluation".localized, for: .normal)
            cancelView.isHidden = false
            cancelHight.constant = 92
            suggestionView.isHidden = false
            refundView.isHidden = true
        }else if viewModel?.orderdetails.value?.data?.statusKey ?? 0 == 5 {
            cancelView.isHidden = true
            cancelHight.constant = 0
            refundView.isHidden = false
            suggestionView.isHidden = true
            if viewModel?.orderdetails.value?.data?.is_refunded ?? 0 == 1 {
                cancelLbl.text = "The reservation amount has been refunded after applying the cancellation policy".localized
                cancelImg.image = UIImage(named: "done 1")
            }else {
                cancelLbl.text = "Reservation and cancellation policy will apply and the reservation amount will be refunded to you as soon as possible".localized
                cancelImg.image = UIImage(named: "alert 1")
            }
        }else {
            cancelView.isHidden = true
            cancelHight.constant = 0
            suggestionView.isHidden = false
            refundView.isHidden = true
        }
        copy = ""
        copy = "\("Booked on".localized) \(viewModel?.orderdetails.value?.data?.date ?? "") \(viewModel?.orderdetails.value?.data?.time ?? "") \n"
        for index in viewModel?.orderdetails.value?.data?.service ?? [] {
            var loc = if index.locationType ?? "" == "home" {"Domestic service".localized}else{"At the center".localized}
            if Localizer.current == .english {
                copy = "\(copy)Booking \(index.name ?? "") service for \(index.duration ?? "") minutes at a price of \(index.price ?? "") SAR for \(loc)\n"
            }else {
                copy = "\(copy)تم حجز خدمه \(index.name ?? "") لمده \(index.duration ?? "") دقيقه بسعر \(index.price ?? "") ريال \(loc)\n"
            }
        }
        service.removeAll()
        service.append(contentsOf: viewModel?.orderdetails.value?.data?.service ?? [])
        servicesTbl.reloadData()
    }
}
// MARK: - ...  View Contract
extension DetailsreservationVC {
}
extension DetailsreservationVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: DetailsreservationTableViewCell.self, indexPath)
        cell.model = service[safe: indexPath.row]
        cell.isgift = viewModel?.orderdetails.value?.data?.isGift ?? 0
        cell.statuskey = viewModel?.orderdetails.value?.data?.statusKey ?? 0
        cell.statusValue = viewModel?.orderdetails.value?.data?.status ?? ""
        cell.loctype = viewModel?.orderdetails.value?.data?.locationType ?? ""
        cell.setup()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
extension DetailsreservationVC: NotificationSubscriber {
    func notificationControlWillPresent(notificationType: String?, json: String, closure: SoundHandler?) {
        closure?(true)
        if notificationType ?? "" != "reservation" || json.int ?? 0 != orderId {
            return
        }
        viewModel?.fetchorderdetails()
    }
}
