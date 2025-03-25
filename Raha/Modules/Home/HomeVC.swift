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
    @IBOutlet weak var scrollContainerView: UIScrollView!
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
    var filter : FilterServiceModel = FilterServiceModel.init()
    let locationManager = CLLocationManager()
    var timer: TimeHelper?
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
        viewModel?.homestatus.listen(on: { [weak self] value in
            self?.reloadhome()
        })
        viewModel?.userddata.listen(on: { [weak self] value in
            self?.userImg.setImage(url: self?.viewModel?.userddata.value?.data?.avatar ?? "")
        })
       
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        scrollContainerView.delegate = self
        centerTbl.skeleton()
        centerTbl.delegate = self
        centerTbl.dataSource = self
        centerTbl.observe()
        if UD.user != nil {
            viewModel?.getprofile()
            viewModel?.fetchaddresses()
        }else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                viewModel?.lat.send(30.5765)
                viewModel?.lng.send(31.5042)
                viewModel?.fetchhome()
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
                    viewModel?.lat.send(degree?.latitude ?? 0)
                    viewModel?.lng.send(degree?.longitude ?? 0)
                    viewModel?.fetchhome()
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
        filterView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.filter()
        }).store(self)
        locLbl.UIViewAction {
            self.coordinator?.selectaddress()
        }
        searchTxf.publisher.listen(on: { [weak self]_ in
            self?.timer?.stopTimer()
            self?.timer = nil
            self?.timer = .init(seconds: 1, closure: { [self] (second) in
                self?.timer?.stopTimer()
                self?.timer = nil
                self?.viewModel?.name.send(self?.searchTxf.text ?? "")
                self?.viewModel?.homedata.send([])
                self?.viewModel?.fetchhome()
            })
            
        }).store(self)
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
                viewModel?.lat.send(index.lat?.double() ?? 0.0)
                viewModel?.lng.send(index.lng?.double() ?? 0.0)
                viewModel?.fetchhome()
                break
            }
        }
    }
    func reloadhome() {
        if viewModel?.homedata.value?.count ?? 0 == 0 {
            centerTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Centers list is empty".localized)
            
        } else {
            hideEmptyScreen()
            centerTbl.isHidden = false
        }
        centerTbl.skeleton()
        centerTbl.stopSwipeButtom()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // The user has not yet made a choice regarding location permission.
                break
            case .restricted, .denied:
                viewModel?.lat.send(30.5765)
                viewModel?.lng.send(31.5042)
                viewModel?.fetchhome()
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
                    viewModel?.lat.send(degree?.latitude ?? 0)
                    viewModel?.lng.send(degree?.longitude ?? 0)
                    viewModel?.fetchhome()
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainerView {
            let tableViewVisibleHeight = scrollContainerView.bounds.size.height
               let tableViewContentHeight = scrollContainerView.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && scrollContainerView.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchhome()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == scrollContainerView {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchhome()
                } else {
                    scrollView.stopSwipeButtom()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.homedata.value?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: CentersTableViewCell.self, indexPath)
        cell.model = viewModel?.homedata.value?[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
  
