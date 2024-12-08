//
//  SubscriptionsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SubscriptionsCoordinator: Coordinator, ChangeClubVCDelegate, PaymentMethodVCCDelegate, deleteAccountPopupVCDelegate, FilterpackageVCDelegate {
    typealias PresentingView = SubscriptionsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SubscriptionsCoordinator {
    func changeclub() {
        guard let scene = R.storyboard.changeClubStoryboard.changeClubVC() else { return }
        scene.delegate = self
        scene.issubscribe = true
        view?.pushPop(scene)
    }
    func done(club : SelectclubDatum?) {
        view?.clubId = club?.id ?? 0
        view?.club = club
        view?.clickBtn()
    }
    func paymentmethod() {
        guard let scene = R.storyboard.paymentMethodStoryboard.paymentMethodVC() else { return }
        scene.delegate = self
        scene.methodId = view?.viewModel?.paymentId.value ?? 0
        view?.pushPop(scene)
    }
    func done(paymentId: Int) {
        view?.viewModel?.paymentId.send(paymentId)
        view?.stopLoading()
        view?.viewModel?.subscribe()
    }
    func paymentdone() {
        guard let scene = R.storyboard.successpaymentStoryboard.successpaymentVC() else { return }
        view?.pushPop(scene)
    }
    func deletesubscribe() {
        guard let scene = R.storyboard.deleteaccountpopupStoryboard.deleteaccountpopupVC() else { return }
        scene.viewType = .subscribe
        scene.delegate = self
        view?.pushPop(scene)
    }
    func checksubscribe() {
        guard let scene = R.storyboard.deleteaccountpopupStoryboard.deleteaccountpopupVC() else { return }
        scene.viewType = .resubscribe
        scene.delegate = self
        view?.pushPop(scene)
    }
    func filter() {
        guard let scene = R.storyboard.filterpackageStoryboard.filterpackageVC() else { return }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.startLoading()
        if view?.viewModel?.checkclubId.value ?? 0 == 0 {
            view?.viewModel?.deletesubscribe()
        }else {
            view?.viewModel?.subscribe()
        }
    }
    func doneFilter(price: String, duaration: String) {
        view?.viewModel?.price.send(price)
        view?.viewModel?.duration.send(duaration)
        view?.viewModel?.mysubscribe.send([])
        view?.viewModel?.resetPaginator()
        view?.viewModel?.clearDataSource()
        view?.viewModel?.fetchmypackages()
    }
}
