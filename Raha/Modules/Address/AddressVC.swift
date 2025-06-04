//
//  AddressVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - ...  ViewController - Vars
class AddressVC: BaseController,Reloader {
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addressLTbl: UITableView!
    var viewModel: AddressViewModel?
    var coordinator: AddressCoordinator?
}

// MARK: - ...  LifeCycle
extension AddressVC {
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
            self?.reload()
            self?.stopLoading()
        })
        viewModel?.deltedata.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchaddresses()
            
        })
        
       
    }
}
// MARK: - ...  Functions
extension AddressVC {
    func setup() {
        addressLTbl.skeleton()
        addressLTbl.delegate = self
        addressLTbl.dataSource = self
        addressLTbl.observe()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchaddresses()
        addBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.addaddress()
        }).store(self)
        swipeTopRefresh(scrollView: addressLTbl) { [weak self] in
            self?.stopSwipeTop()
            self?.viewModel?.resetPaginator()
            self?.viewModel?.clearDataSource()
            self?.viewModel?.fetchaddresses()
        }
    }
    func reload() {
        if viewModel?.dataSource()?.count ?? 0 == 0 {
            addressLTbl.isHidden = true
            showEmptyScreen(for: 300, title: "Addresses list is empty".localized)
            
        } else {
            hideEmptyScreen()
            addressLTbl.isHidden = false
        }
        addressLTbl.skeleton()
        addressLTbl.stopSwipeButtom()
        
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
extension AddressVC {
}
extension AddressVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == addressLTbl {
            let tableViewVisibleHeight = addressLTbl.bounds.size.height
               let tableViewContentHeight = addressLTbl.contentSize.height
               let tableViewOffsetThreshold = tableViewContentHeight - tableViewVisibleHeight - 2 * 100
               
            if scrollView.contentOffset.y > tableViewOffsetThreshold && addressLTbl.isDragging {
                // Fetch more data here
                if case self.viewModel?.canPaginate() = true {
                    self.viewModel?.fetchaddresses()
                }
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == addressLTbl {
            scrollView.swipeButtomRefresh { [weak self] in
                if case self?.viewModel?.canPaginate() = true {
                    self?.viewModel?.fetchaddresses()
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
        var cell = tableView.cell(type: AddresslistTableViewCell.self, indexPath)
        cell.model = viewModel?.dataSource()?[safe: indexPath.row]
        getAddressFromLatLon(latitude: Double(viewModel?.dataSource()?[safe: indexPath.row]?.lat ?? "0.0") ?? 0.0, longitude: Double(viewModel?.dataSource()?[safe: indexPath.row]?.lng ?? "0.0") ?? 0.0) { address in
                    if let address = address {
                        cell.titleLbl.text = address
                    } else {
                        print("Unable to get address")
                    }
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension AddressVC : AddresslistTableViewCellDelegate {
    func defult(wasPressedOnCell cell: AddresslistTableViewCell, model: AddressesDatum) {
        if model.isDefault ?? 0 == 1 {
            return
        }
        viewModel?.addressId.send(model.id ?? 0)
        startLoading()
        viewModel?.defultaddress()
    }
    
    func delete(wasPressedOnCell cell: AddresslistTableViewCell, model: AddressesDatum) {
        viewModel?.addressId.send(model.id ?? 0)
        coordinator?.delete()
    }
    
    func edit(wasPressedOnCell cell: AddresslistTableViewCell, model: AddressesDatum) {
        coordinator?.editaddress(model: model)
    }
    
}
