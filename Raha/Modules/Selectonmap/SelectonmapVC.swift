//
//  SelectonmapVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GoogleMaps
protocol SelectonmapVCDelegate: AnyObject {
    func locate(lat : Double , lng : Double , loc : String)
}
// MARK: - ...  ViewController - Vars
class SelectonmapVC: BaseController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: SelectonmapViewModel?
    var coordinator: SelectonmapCoordinator?
    var lat: Double?
    var lng: Double?
    var lat1: Double = 0
    var lng1: Double = 0
    var locationManager = CLLocationManager()
    var currentLocationMarker: MKPointAnnotation?
    weak var delegate: SelectonmapVCDelegate?
    var address = ""

}

// MARK: - ...  LifeCycle
extension SelectonmapVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
}
// MARK: - ...  Functions
extension SelectonmapVC {
   
}
// MARK: - ...  View Contract
extension SelectonmapVC {
}


extension SelectonmapVC: MKMapViewDelegate, CLLocationManagerDelegate {
    func setupMap() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        saveBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.delegate?.locate(lat: self?.lat ?? 0, lng: self?.lng ?? 0, loc: self?.address ?? "")
        }).store(self)

        backBtn.publisher.listen(on: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        updateCamera(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }

    func updateCamera(lat: Double, lng: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        self.lat = lat
        self.lng = lng
        let position = CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0)

        // Remove old marker
        if let currentMarker = currentLocationMarker {
            mapView.removeAnnotation(currentMarker)
        }

        // Add new marker
        currentLocationMarker = MKPointAnnotation()
        currentLocationMarker?.coordinate = position
        currentLocationMarker?.title = "Selected Location"
        if let marker = currentLocationMarker {
            mapView.addAnnotation(marker)
        }

        reverseGeocode(lat: coordinate.latitude, lng: coordinate.longitude)
    }

    @objc func didTapOnMap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        lat = coordinate.latitude
        lng = coordinate.longitude

        // Remove old marker
        if let currentMarker = currentLocationMarker {
            mapView.removeAnnotation(currentMarker)
        }

        // Add new marker
        currentLocationMarker = MKPointAnnotation()
        currentLocationMarker?.coordinate = coordinate
        currentLocationMarker?.title = "Selected Location"
        if let marker = currentLocationMarker {
            mapView.addAnnotation(marker)
        }

        reverseGeocode(lat: coordinate.latitude, lng: coordinate.longitude)
    }

    func reverseGeocode(lat: Double, lng: Double) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lng)

        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                let address = self?.getAddressFromPlacemark(placemark) ?? "Unknown Location"
                self?.address = address
                print("Location: \(address)")
            }
        }
    }

    func getAddressFromPlacemark(_ placemark: CLPlacemark) -> String {
        var address = ""
        if let street = placemark.thoroughfare { address += street }
        if let city = placemark.locality { address += ", \(city)" }
        if let state = placemark.administrativeArea { address += ", \(state)" }
        if let zip = placemark.postalCode { address += " \(zip)" }
        return address
    }
}
