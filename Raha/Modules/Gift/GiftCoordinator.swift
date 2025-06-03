//
//  GiftCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class GiftCoordinator: Coordinator, SelectonmapVCDelegate {
    typealias PresentingView = GiftVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension GiftCoordinator {
    func locate(){
        guard let scene = R.storyboard.selectonmapStoryboard.selectonmapVC() else { return }
        if view?.gift?.lat ?? "" !=  "" {
            scene.lat1 = view?.gift?.lat?.double() ?? 0
            scene.lng1 = view?.gift?.lng?.double() ?? 0
        }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func locate(lat: Double, lng: Double, loc: String) {
        view?.gift?.lat = lat.string
        view?.gift?.lng = lng.string
        view?.addressLbl.text = loc
        view?.addressLbl.textColor = R.color.black()
    }
}
