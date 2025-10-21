//
//  DetailsreservationCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class DetailsreservationCoordinator: Coordinator, RatingPopupVCDelegate {
    typealias PresentingView = DetailsreservationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DetailsreservationCoordinator {
    func showfatora() {
        guard let scene = R.storyboard.showfatoaraStoryboard.showfatoaraVC() else { return }
        scene.url = view?.viewModel?.orderdetails.value?.data?.invoiceUrl ?? ""
        scene.downlaodurl = view?.viewModel?.orderdetails.value?.data?.invoice_download_url ?? ""
        view?.push(scene)
    }
    func cancelorder(id:Int) {
        guard let scene = R.storyboard.cancelOrderStoryboard.cancelOrderVC() else { return }
        scene.centerId = id
        view?.push(scene)
    }
    func sendcomplain(id: Int) {
        guard let scene = R.storyboard.sendcomplainStoryboard.sendcomplainVC() else { return }
        scene.orderId = id
        view?.push(scene)
    }
    func rateorder(id:Int) {
        guard let scene = R.storyboard.ratingPopupStoryboard.ratingPopupVC() else { return }
        scene.orderId = id
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.startLoading()
        view?.viewModel?.fetchorderdetails()
    }
}
