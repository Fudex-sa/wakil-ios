//
//  SelectLocVC.swift
//  Superfan
//
//  Created by ADAM on 16/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
protocol SelectLocVCDelegate: AnyObject {
    func locate(lat : Double , lng : Double , loc : String)
}
// MARK: - ...  ViewController - Vars
class SelectLocVC: BaseController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    var viewModel: SelectLocViewModel?
    var coordinator: SelectLocCoordinator?
    var location: LocationHelper?
    var google: GoogleMapHelper?
    var lat: Double?
    var lng: Double?
    var currentLocationMarker: GMSMarker?
    weak var delegate: SelectLocVCDelegate?

}

// MARK: - ...  LifeCycle
extension SelectLocVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension SelectLocVC {
    func setup() {
        changeColoe()
        google = .init()
        google?.mapView = mapView
        google?.delegate = self
        location = .init()
        location?.onUpdateLocation = { degree in
            if (self.lat ?? 0 !=  0){
                self.google?.updateCamera(lat: self.lat ?? 0, lng: self.lng ?? 0)
                return
            }
            self.google?.updateCamera(lat: degree?.latitude ?? 0, lng: degree?.longitude ?? 0)
        }
        location?.currentLocation()
        
        saveBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.delegate?.locate(lat: self?.lat ?? 0, lng: self?.lng ?? 0 , loc: self?.locLbl.text ?? "")
        }).store(self)
        backBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            saveBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
    private func getAddressFromPlacemark(_ placemark: CLPlacemark) -> String {
            var address = ""
            
            if let street = placemark.thoroughfare {
                address += street
            }
            
            if let city = placemark.locality {
                if !address.isEmpty {
                    address += ", "
                }
                address += city
            }
            
            if let state = placemark.administrativeArea {
                if !address.isEmpty {
                    address += ", "
                }
                address += state
            }
            
            if let zipCode = placemark.postalCode {
                if !address.isEmpty {
                    address += " "
                }
                address += zipCode
            }
            
            return address
        }
}
// MARK: - ...  View Contract
extension SelectLocVC {
}
extension SelectLocVC: GoogleMapHelperDelegate {
    func didChangeCameraLocation(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.currentLocationMarker?.map = nil
        self.currentLocationMarker = nil
        let position = CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0)
        self.currentLocationMarker = GMSMarker(position: position)
        self.currentLocationMarker?.icon = UIImage(named: "marker")
        self.currentLocationMarker?.map = self.mapView
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: self.lat ?? 0, longitude: self.lng ?? 0)) { (placemarks, error) in
                   if let error = error {
                       print("Geocoding error: \(error.localizedDescription)")
                       return
                   }
                   
                   if let placemark = placemarks?.first {
                       let address = self.getAddressFromPlacemark(placemark)
                       self.locLbl.text = address
                       print("Location: \(address)")
                   }
               }
    }
    func didTapOnMap(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        self.currentLocationMarker?.map = nil
        self.currentLocationMarker = nil
        let position = CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0)
        self.currentLocationMarker = GMSMarker(position: position)
        self.currentLocationMarker?.icon = UIImage(named: "marker")
        self.currentLocationMarker?.map = self.mapView
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: self.lat ?? 0, longitude: self.lng ?? 0)) { (placemarks, error) in
                   if let error = error {
                       print("Geocoding error: \(error.localizedDescription)")
                       return
                   }
                   
                   if let placemark = placemarks?.first {
                       let address = self.getAddressFromPlacemark(placemark)
                       self.locLbl.text = address
                       print("Location: \(address)")
                   }
               }
    }
}
