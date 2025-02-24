//
//  MapHelper.swift
//  homeCheif
//
//  Created by mohamed abdo on 4/8/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class GoogleMapHelper: NSObject, MapRouteHelper, MapAddressHelper {
    /* mapview */
    private var _mapView: GMSMapView!
    private var marker = GMSMarker()

    /* delegates */
    private weak var _delegate: GoogleMapHelperDelegate?
    private weak var _markerDataSource: MarkerDataSource?
    /* AR*/
    //private var moveMent: ARCarMovement?
    internal let geocoder = GMSGeocoder()

    /** options **/
    var useNearestPlaces: Bool = false
    var useRoad: Bool = true
    var useMarkerDataSoruce: Bool = true
    var useARMovement: Bool = true
    var zoom: Zoom = .streets
    var clearOnChangeMap: Bool = true
    /** options **/

    var mapView: GMSMapView? {
        get {
            return _mapView
        }
        set {
            _mapView = newValue
            _mapView.delegate = self
        }
    }
    var delegate: GoogleMapHelperDelegate? {
        get {
            return _delegate
        } set {
            _delegate = newValue
        }
    }
    var markerDataSource: MarkerDataSource? {
        get {
            return _markerDataSource
        } set {
            _markerDataSource = newValue
        }
    }
    override init() {
        super.init()
//        if useARMovement {
//            self.moveMent = ARCarMovement()
//            self.moveMent?.delegate = self
//        }
    }

    public func reload() {
    }
}

extension GoogleMapHelper: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        self.delegate?.didTapOnMyLocation(lat: location.latitude, lng: location.longitude)
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        self.delegate?.didTapOnMyLocation()
        return true
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.delegate?.didTapOnMarker(marker: marker)
        return false
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("cliecked on map")
        self.delegate?.didTapOnMap(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //self.delegate?.didChangeCameraLocation(lat: position.target.latitude, lng: position.target.longitude)
    }
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        if clearOnChangeMap {
            mapView.clear()
        }
        self.delegate?.didChangeCameraLocation(lat: cameraPosition.target.latitude, lng: cameraPosition.target.longitude)
//        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
//            guard error == nil else {
//                return
//            }
//            if let result = response?.firstResult() {
//                /** set Marker **/
//                var lines: [String] = []
//                var title = ""
//                var snippet = ""
//                if result.lines != nil {
//                    lines.append(contentsOf: result.lines!)
//                }
//                title = lines.first!
//                snippet = title
//                if lines.isset(1) {
//                    snippet = lines[1]
//                }
//                /** call delegate **/
//                self.delegate?.didChangeCameraLocation(lat: result.coordinate.latitude, lng: result.coordinate.longitude)
//                self.addressDelegate?.didGetAddress(name: title)
//                self.addressDelegate?.didGetAddress(snippet: snippet)
//                /** call **/
//            }
//        }
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return self.markerDataSource?.infoWindow(marker: marker)
    }
    public func updateCamera(lat: Double, lng: Double) {
        //self.mapView?.clear()
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: self.zoom.rawValue)
        self.mapView?.camera = camera
        self.mapView?.animate(to: camera)
    }
    public func setMarker(position: CLLocationCoordinate2D!, title: String? = nil, snippet: String? = nil) {
        marker.position = position
        marker.title = title
        marker.snippet = snippet
        self.setMarkerAttribute(marker: &marker)
        marker.map = mapView
    }
    public func imageForLocation(lat: Double?, lng: Double?) -> String? {
        if let lat = lat, let lng = lng {
            let url = "https://maps.google.com/maps/api/staticmap?center=\(lat),\(lng)&zoom=15&size=200x200&sensor=false&key=\(Keys.googleAPI)"
            return url
        } else {
            return ""
        }
    }
}

extension GoogleMapHelper: MarkerDelegate {
    public func setMarkerAttribute( marker: inout GMSMarker) {
        let attr = self.markerDataSource?.marker()
        if let options = attr {
            if options.use == .icon {
                marker.icon = options.icon
            } else if options.use == .view {
                marker.iconView = options.iconView
            } else if options.use == .image {
                marker.iconView = options.image
            } else {
                let view = UIImageView()
                view.tintColor = options.color
                marker.iconView = view
            }
        }
    }
    public func setMarker(marker: GMSMarker?) {
        marker?.map = mapView
    }
    public func removeMarker(marker: GMSMarker?) {
        marker?.map = nil
    }
    func refresh(lat: Double! = nil, lng: Double! = nil) {
        self.mapView?.clear()
        guard let markers = self.markerDataSource?.setMarkers() else { return }
        markers.forEach {
            var marker = $0
            if marker.map != nil {
                marker.map = nil
            }
            self.setMarkerAttribute(marker: &marker)
            self.setMarker(marker: marker)
        }
        if lat != nil && lng != nil {
            self.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
    }
    func refreshARMovement(lat: Double! = nil, lng: Double! = nil) {
        self.mapView?.clear()
        guard let markers = self.markerDataSource?.setMarkers() else { return }
        markers.forEach { (marker) in
            if marker.oldPosition == nil {
                marker.oldPosition = marker.position
            }
//            self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!,
//                                         andNewCoordinate: marker.position, inMapview: self.mapView, withBearing: 0)
        }
        if lat != nil && lng != nil {
            self.setMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
    }
    func refreshARMovement(marker: GMSMarker) {
        if marker.oldPosition == nil {
            marker.oldPosition = marker.position
        }
//        self.moveMent?.arCarMovement(marker, withOldCoordinate: marker.oldPosition!, andNewCoordinate: marker.position, inMapview: nil, withBearing: 0)
    }
}
/** AR **/
//extension GoogleMapHelper: ARCarMovementDelegate {
//    func arCarMovement(_ movedMarker: GMSMarker?) {
//    }
//}

extension GoogleMapHelper {
    //        /** Degrees to Radian **/
    public func degreeToRadian(angle:CLLocationDegrees) -> CGFloat {
        return (  (CGFloat(angle)) / 180.0 * .pi  )
    }
    
    //        /** Radians to Degrees **/
    public func radianToDegree(radian:CGFloat) -> CLLocationDegrees {
        return CLLocationDegrees(  radian * CGFloat(180.0 / .pi)  )
    }
    
    public func middlePointOfListMarkers(listCoords: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        
        var xPoint = 0.0 as CGFloat
        var yPoint = 0.0 as CGFloat
        var zPoint = 0.0 as CGFloat
        
        for coordinate in listCoords {
            let lat:CGFloat = degreeToRadian(angle: coordinate.latitude)
            let lon:CGFloat = degreeToRadian(angle: coordinate.longitude)
            xPoint += cos(lat) * cos(lon)
            yPoint += cos(lat) * sin(lon)
            zPoint += sin(lat)
        }
        
        xPoint /= CGFloat(listCoords.count)
        yPoint /= CGFloat(listCoords.count)
        zPoint /= CGFloat(listCoords.count)
        
        let resultLon: CGFloat = atan2(yPoint, xPoint)
        let resultHyp: CGFloat = sqrt(xPoint*xPoint+yPoint*yPoint)
        let resultLat:CGFloat = atan2(zPoint, resultHyp)
        
        let newLat = radianToDegree(radian: resultLat)
        let newLon = radianToDegree(radian: resultLon)
        let result:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
        
        return result
        
    }
}
