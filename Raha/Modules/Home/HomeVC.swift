//
//  HomeVC.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - ...  ViewController - Vars
class HomeVC: BaseController, CLLocationManagerDelegate {
    @IBOutlet weak var centerTbl: UITableView!
    @IBOutlet weak var dotsPage: UIPageControl!
    @IBOutlet weak var slidersCollection: UICollectionView!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var notBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    var viewModel: HomeViewModel?
    var coordinator: HomeCoordinator?
    var addressdata : AddressesDatum?
    var location: LocationHelper?
    var lat = 0.0
    var lng = 0.0
    var isaddress = false
    let locationManager = CLLocationManager()
}

// MARK: - ...  LifeCycle
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        (self.tabBarController as? CustomTabBarController)?.showTabBar()
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
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reloadaadress()
        })
        viewModel?.userddata.listen(on: { [weak self] value in
            self?.userImg.setImage(url: self?.viewModel?.userddata.value?.data?.avatar ?? "")
        })
       
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        if UD.user != nil {
            viewModel?.getprofile()
            viewModel?.fetchaddresses()
        }else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied: break
//                NetworkManager.instance.headers.append(.init(name: "Lat", value: "26.37743421684474" ))
//                NetworkManager.instance.headers.append(.init(name: "Lng", value: "50.17044570297003" ))
//                viewModel?.fetchshoptypes()
            case .authorizedAlways, .authorizedWhenInUse:
                location = .init()
                location?.useOnlyoneTime = false
                location?.onUpdateLocation = { [self] degree in
                    if self.lat != 0 {
                        return
                    }
                    self.lat = degree?.latitude ?? 0
                    self.lng = degree?.longitude ?? 0
                    isaddress = true
//                    viewModel?.lat.send(degree?.latitude ?? 0)
//                    viewModel?.lng.send(degree?.longitude ?? 0)
//                    viewModel?.fetchshoptypes()
                }
                location?.currentLocation()
            @unknown default:
                // Handle future cases if they are added in later iOS versions.
                break
            }
        }
        langBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.selectlanguage()
        }).store(self)
        locLbl.UIViewAction {
            self.coordinator?.selectaddress()
        }
    }
    func reloadaadress() {
        if viewModel?.items.value?.count ?? 0 == 0 {
            coordinator?.addaddress()
            return
        }
        for index in viewModel?.items.value ?? [] {
            if index.isDefault ?? 0 == 1 {
                locLbl.text = "\(index.street ?? "") - \(index.district ?? "") - \(index.cityID?.name ?? "") - \(index.stateID?.name ?? "")"
                addressdata = index
                break
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // The user has not yet made a choice regarding location permission.
                break
            case .restricted, .denied: break
//                viewModel?.lat.send(0.0)
//                viewModel?.lng.send(0.0)
//                if UD.user == nil {
//                    NetworkManager.instance.headers.append(.init(name: "Lat", value: "26.37743421684474" ))
//                    NetworkManager.instance.headers.append(.init(name: "Lng", value: "50.17044570297003" ))
//                    viewModel?.fetchshoptypes()
//                }else {
//                    viewModel?.fetchaddress()
//                }
            case .authorizedAlways, .authorizedWhenInUse:
                // Location permission is authorized.
                location = .init()
                location?.useOnlyoneTime = false
                location?.onUpdateLocation = { [self] degree in
                    if self.lat != 0 {
                        return
                    }
                    self.lat = degree?.latitude ?? 0
                    self.lng = degree?.longitude ?? 0
                    isaddress = true
//                    viewModel?.lat.send(degree?.latitude ?? 0)
//                    viewModel?.lng.send(degree?.longitude ?? 0)
//                    if UD.user == nil {
//                        NetworkManager.instance.headers.append(.init(name: "Lat", value: viewModel?.lat.value?.string ?? "" ))
//                        NetworkManager.instance.headers.append(.init(name: "Lng", value: viewModel?.lng.value?.string ?? ""))
//                        viewModel?.fetchshoptypes()
//                    }else {
//                        viewModel?.fetchaddress()
//                    }
                }
                location?.currentLocation()
            @unknown default:
                // Handle future cases if they are added in later iOS versions.
                break
            }
        }
}
// MARK: - ...  View Contract
extension HomeVC {
}
