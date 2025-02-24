//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import CoreLocation
import GoogleMaps

protocol MapAddressHelper: AnyObject {
    typealias AddressHandler = (String, String) -> Void
    func address(lat: Double, lng: Double, handler: AddressHandler?)
    func address(degree: CLLocationCoordinate2D)
    func address(location: CLLocation)
}
protocol MapAddressDelegate: AnyObject {
    func didGetAddress(name: String)
    func didGetAddress(snippet: String)
}
extension MapAddressDelegate {
    func didGetAddress(name: String) {
    }
    func didGetAddress(snippet: String) {
    }
}

fileprivate weak var _delegate: MapAddressDelegate?
var currentGecoder: Bool = false
extension MapAddressHelper where Self: GoogleMapHelper {
    
    var addressDelegate: MapAddressDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    func address(lat: Double, lng: Double, handler: AddressHandler? = nil) {
        if currentGecoder {
            return
        }
        let location = CLLocation(latitude: lat, longitude: lng)
        currentGecoder = true
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale.init(identifier: Localizer.current.rawValue)) { placemarks, error in
            currentGecoder = false
            guard let result = placemarks?.first else { return }
            var title = ""
            var snippet = ""
            title = "\(result.subThoroughfare ?? "") \(result.thoroughfare ?? "") \(result.subLocality ?? "") \(result.locality ?? "") \(result.country ?? "")"
            snippet = "\(result.subThoroughfare ?? "") \(result.thoroughfare ?? "") \(result.subLocality ?? "") \(result.locality ?? "") \(result.country ?? "")"

            handler?(title, snippet)

        }
    }
    func address(degree: CLLocationCoordinate2D) {
        geocoder.reverseGeocodeCoordinate(degree) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines: [String] = []
                var title = ""
                var snippet = ""
                if result.lines != nil {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }
    func address(location: CLLocation) {
        geocoder.reverseGeocodeCoordinate(location.coordinate) { (response, error) in
            guard error == nil else {
                return
            }
            if let result = response?.firstResult() {
                /** set Marker **/
                var lines: [String] = []
                var title = ""
                var snippet = ""
                if result.lines != nil {
                    lines.append(contentsOf: result.lines!)
                }
                title = lines.first!
                snippet = title
                if lines.isset(1) {
                    snippet = lines[1]
                }
                /** call delegate **/
                self.addressDelegate?.didGetAddress(name: title)
                self.addressDelegate?.didGetAddress(snippet: snippet)
                /** call **/
            }
        }
    }

}
