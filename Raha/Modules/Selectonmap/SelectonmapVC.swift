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
    @IBOutlet weak var addressTbl: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
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
    private let completer = MKLocalSearchCompleter()
    private var completions: [MKLocalSearchCompletion] = []
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
        mapView.mapType = .mutedStandard
        completer.delegate = self
        completer.resultTypes = .address // or .pointOfInterest / .query
        addressTbl.dataSource = self
        addressTbl.delegate = self
        searchBar.delegate = self
        addressTbl.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        if lat ?? 0 != 0 {
            return
        }
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
                self?.searchBar.text = address
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
    private func setSuggestionsVisible(_ visible: Bool, count: Int = 0) {
           let maxHeight: CGFloat = min(CGFloat(count) * 56.0, 300)
           for c in view.constraints {
               if c.firstItem as? UITableView == addressTbl && c.firstAttribute == .height {
                   c.constant = visible ? maxHeight : 0
                   UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
                   return
               }
           }
       }

       private func dropPinAndZoom(to coordinate: CLLocationCoordinate2D, title: String?) {
           let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
           mapView.setRegion(region, animated: true)
           self.lat = coordinate.latitude ?? 0
           self.lng = coordinate.longitude ?? 0
           let position = CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lng ?? 0)

           // Remove old marker
           if let currentMarker = currentLocationMarker {
               mapView.removeAnnotation(currentMarker)
           }

           // Add new marker
           currentLocationMarker = MKPointAnnotation()
           currentLocationMarker?.coordinate = position
           currentLocationMarker?.title = title
           if let marker = currentLocationMarker {
               mapView.addAnnotation(marker)
           }

           //reverseGeocode(lat: coordinate.latitude, lng: coordinate.longitude)
       }
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil } // keep blue dot
        let id = "pin"
        let v = mapView.dequeueReusableAnnotationView(withIdentifier: id)
            as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
        v.markerTintColor = .systemBlue   // or any UIColor
        v.glyphTintColor  = .white
        return v
    }

}
extension SelectonmapVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        completer.queryFragment = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        // Optionally run a search for the typed text (if user pressed search)
        performSearch(for: searchBar.text)
    }

    private func performSearch(for query: String?) {
        guard let q = query, !q.isEmpty else { return }
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = q
        let search = MKLocalSearch(request: req)
        search.start { [weak self] response, error in
            guard let self = self, let item = response?.mapItems.first else { return }
            self.dropPinAndZoom(to: item.placemark.coordinate, title: item.name)
        }
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SelectonmapVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results
        addressTbl.reloadData()
        setSuggestionsVisible(!completions.isEmpty, count: completions.count)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Completer error: \(error.localizedDescription)")
        completions = []
        addressTbl.reloadData()
        setSuggestionsVisible(false)
    }
}

// MARK: - Table View (suggestions)
extension SelectonmapVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        completions.count
    }

    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let suggestion = completions[indexPath.row]
        // nicely format: title + subtitle
        c.textLabel?.text = suggestion.title
        c.detailTextLabel?.text = suggestion.subtitle
        c.textLabel?.numberOfLines = 1
        c.detailTextLabel?.numberOfLines = 1
        c.accessoryType = .disclosureIndicator
        return c
    }

    func tableView(_ tv: UITableView, didSelectRowAt indexPath: IndexPath) {
        tv.deselectRow(at: indexPath, animated: true)
        searchBar.resignFirstResponder()

        let completion = completions[indexPath.row]
        // Build a search request from the selected completion
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let self = self, let item = response?.mapItems.first else {
                print("No map item for completion: \(error?.localizedDescription ?? "nil")")
                return
            }
            self.setSuggestionsVisible(false)
            self.searchBar.text = completion.title
            self.address = completion.title
            completions.removeAll()
            addressTbl.reloadData()
            self.dropPinAndZoom(to: item.placemark.coordinate, title: item.name ?? completion.title)
        }
    }
}
