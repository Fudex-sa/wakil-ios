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
class HomeVC: BaseController, CLLocationManagerDelegate,Reloader {
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var dotImg: UIImageView!
    @IBOutlet weak var sliderView: UIView!
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
    static var itemId: Int?
    static var type: String?
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
        viewModel?.addressstatus.listen(on: { [weak self] value in
            self?.reloadaadress()
        })
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.stopSwipeTop()
            self?.reloadhome()
        })
        viewModel?.slidersFinished.listen(on: { [weak self] value in
            self?.reloadsliders()
        })
        viewModel?.userddata.listen(on: { [weak self] value in
            self?.userImg.setImage(url: self?.viewModel?.userddata.value?.data?.avatar ?? "")
        })
        viewModel?.notcount.listen(on: { [weak self] value in
            if value == 0 {
                self?.dotImg.isHidden = true
            }else {
                self?.dotImg.isHidden = false
            }
        })
       
    }
}
// MARK: - ...  Functions
extension HomeVC {
    func setup() {
        if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "reservation"{
            coordinator?.detailsreservation(id: HomeVC.itemId ?? 0)
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else  if HomeVC.type ?? "" != ""  &&  HomeVC.type ?? "" == "complaint"{
            coordinator?.complains()
            HomeVC.type = ""
            HomeVC.itemId = 0
        }else if HomeVC.type ?? "" == "profile" &&  HomeVC.type ?? "" == "booking"{
            coordinator?.notification()
            HomeVC.type = ""
            HomeVC.itemId = 0
        }
        scrollContainerView.delegate = self
        centerTbl.skeleton()
        centerTbl.delegate = self
        centerTbl.dataSource = self
        centerTbl.observe()
        slidersCollection.skeleton()
        slidersCollection.delegate = self
        slidersCollection.dataSource = self
        slidersCollection.observe()
        viewModel?.fetchsliders()
        if UD.user != nil {
            viewModel?.updatelang()
            viewModel?.getprofile()
            viewModel?.getnotcount()
            if UD.address == nil {
                viewModel?.fetchaddresses()
            }else {
//                locLbl.text = "\(UD.address?.district ?? "") - \(UD.address?.cityID?.name ?? "") - \(UD.address?.stateID?.name ?? "")"
                getAddressFromLatLon(latitude: Double(UD.address?.lat ?? "0.0") ?? 0.0, longitude: Double(UD.address?.lng ?? "0.0") ?? 0.0) { address in
                    if let address = address {
                        self.locLbl.text = address
                    } else {
                        print("Unable to get address")
                    }
                }
                addressdata = UD.address
                viewModel?.lat.send(UD.address?.lat?.double() ?? 0.0)
                viewModel?.lng.send(UD.address?.lng?.double() ?? 0.0)
                viewModel?.resetPaginator()
                viewModel?.clearDataSource()
                viewModel?.fetchhome()
            }
        }else {
            userImg.isHidden = true
            currentlocation()
        }
        userImg.UIViewAction {
            self.coordinator?.profile()
        }
        langBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.selectlanguage()
        }).store(self)
        notBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.notification()
        }).store(self)
        filterView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.filter()
        }).store(self)
        locLbl.UIViewAction {
            self.coordinator?.selectaddress()
        }
        searchTxf
            .editingChangedPublisher
            .compactMap { [weak searchTxf] in searchTxf?.text }
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.viewModel?.name.send(text)
                self?.viewModel?.resetPaginator()
                self?.viewModel?.clearDataSource()
                self?.viewModel?.fetchhome()
            }
            .store(self)
        swipeTopRefresh(scrollView: scrollContainerView) { [weak self] in
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchhome()
        }
    }
    func reloadaadress() {
        if viewModel?.addressList.value?.count ?? 0 == 0 {
            if UD.lat == nil {
                coordinator?.currentloc()
            }else {
                viewModel?.lat.send(UD.lat ?? 0.0)
                viewModel?.lng.send(UD.lng ?? 0.0)
                if UD.lat ?? 0.0 != 0.0 {
                    lat = UD.lat ?? 0.0
                    lng = UD.lng ?? 0.0
                    getAddressFromLatLon(latitude: self.lat, longitude: self.lng) { address in
                        if let address = address {
                            self.locLbl.text = address
                        } else {
                            print("Unable to get address")
                        }
                    }
                }
                viewModel?.resetPaginator()
                viewModel?.clearDataSource()
                viewModel?.fetchhome()
            }
            return
        }
        for index in viewModel?.addressList.value ?? [] {
            if index.isDefault ?? 0 == 1 {
//                locLbl.text = "\(index.district ?? "") - \(index.cityID?.name ?? "") - \(index.stateID?.name ?? "")"*/
                getAddressFromLatLon(latitude: Double(index.lat ?? "0.0") ?? 0.0, longitude: Double(index.lng ?? "0.0") ?? 0.0) { address in
                    if let address = address {
                        self.locLbl.text = address
                    } else {
                        print("Unable to get address")
                    }
                }
                addressdata = index
                UD.address = index
                viewModel?.lat.send(index.lat?.double() ?? 0.0)
                viewModel?.lng.send(index.lng?.double() ?? 0.0)
                viewModel?.resetPaginator()
                viewModel?.clearDataSource()
                viewModel?.fetchhome()
                break
            }
        }
    }
    func reloadhome() {
        if viewModel?.items.value?.count ?? 0 == 0 {
            centerTbl.isHidden = true
            showEmptyScreen(for: 400, title: "Centers list is empty".localized)
            
        } else {
            hideEmptyScreen()
            centerTbl.isHidden = false
        }
        centerTbl.skeleton()
        centerTbl.stopSwipeButtom()
    }
    func reloadsliders() {
        if viewModel?.sliders.value?.count ?? 0  == 0 {
            sliderView.isHidden = true
        }else {
            sliderView.isHidden = false
        }
        slidersCollection.reloadData()
    }
    func currentlocation() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
//            viewModel?.lat.send(30.5765)
//            viewModel?.lng.send(31.5042)
            viewModel?.resetPaginator()
            viewModel?.clearDataSource()
            viewModel?.fetchhome()
            self.locLbl.text = ""
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            location = .init()
            location?.useOnlyoneTime = false
            location?.onUpdateLocation = { [self] degree in
                if self.lat != 0.0 {
                    return
                }
                self.lat = degree?.latitude ?? 0
                self.lng = degree?.longitude ?? 0
                UD.lat = lat
                UD.lng = lng
                getAddressFromLatLon(latitude: self.lat, longitude: self.lng) { address in
                    if let address = address {
                        self.locLbl.text = address
                    } else {
                        print("Unable to get address")
                    }
                }

                isaddress = true
                viewModel?.lat.send(degree?.latitude ?? 0)
                viewModel?.lng.send(degree?.longitude ?? 0)
                viewModel?.resetPaginator()
                viewModel?.clearDataSource()
                viewModel?.fetchhome()
            }
            location?.currentLocation()
        @unknown default:
            // Handle future cases if they are added in later iOS versions.
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // The user has not yet made a choice regarding location permission.
                break
            case .restricted, .denied:
//                viewModel?.lat.send(30.5765)
//                viewModel?.lng.send(31.5042)
                viewModel?.resetPaginator()
                viewModel?.clearDataSource()
                viewModel?.fetchhome()
                self.locLbl.text = ""
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                // Location permission is authorized.
                location = .init()
                location?.useOnlyoneTime = false
                location?.onUpdateLocation = { [self] degree in
                    if self.lat != 0.0 {
                        return
                    }
                    self.lat = degree?.latitude ?? 0
                    self.lng = degree?.longitude ?? 0
                    UD.lat = lat
                    UD.lng = lng
                    getAddressFromLatLon(latitude: self.lat, longitude: self.lng) { address in
                        if let address = address {
                            self.locLbl.text = address
                        } else {
                            print("Unable to get address")
                        }
                    }
                    isaddress = true
                    viewModel?.lat.send(degree?.latitude ?? 0)
                    viewModel?.lng.send(degree?.longitude ?? 0)
                    viewModel?.resetPaginator()
                    viewModel?.clearDataSource()
                    viewModel?.fetchhome()
                }
                location?.currentLocation()
            @unknown default:
                // Handle future cases if they are added in later iOS versions.
                break
            }
        }

    func getAddressFromLatLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        let locale = Locale(identifier: "lang".localized) // e.g., "ar" or "en"
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                print("Reverse geocode failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                var addressString = ""
                
                if let name = placemark.name {
                    addressString += name + ", "
                }
                if let city = placemark.locality {
                    addressString += city + ", "
                }
                if let country = placemark.country {
                    addressString += country
                }
                completion(addressString)
            } else {
                completion(nil)
            }
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
        return viewModel?.items.value?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: CentersTableViewCell.self, indexPath)
        cell.model = viewModel?.items.value?[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        coordinator?.detailscenter(id: viewModel?.items.value?[safe: indexPath.row]?.id ?? 0)
    }
    
}
  
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)

       }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == slidersCollection {
            dotsPage.currentPage = indexPath.row
        }
        }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          dotsPage.numberOfPages = viewModel?.sliders.value?.count ?? 0
          return viewModel?.sliders.value?.count ?? 0
          
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: SlidersCollectionViewCell.self, indexPath)
            cell.model = viewModel?.sliders.value?[safe: indexPath.row]
            cell.setupsliders()
            return cell
            
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 0
    }
  }
