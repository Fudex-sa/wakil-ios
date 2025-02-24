//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import CoreLocation
import GoogleMaps
import GooglePlaces

protocol MarkerDataSource: AnyObject {
    func marker() -> MarkerAttrbuite?
    func infoWindow(marker: GMSMarker) -> UIView?
    func setMarkers() -> [GMSMarker]
}
extension MarkerDataSource {
    func marker() -> MarkerAttrbuite? {
        return nil
    }
    func setMarkers() -> [GMSMarker] {
        return []
    }
    func infoWindow(marker: GMSMarker) -> UIView? {
        return nil
    }
}
protocol MarkerDelegate: AnyObject {
    func refresh()
    func refreshARMovement()
}
extension MarkerDelegate {
    func refresh() {
    }
    func refreshARMovement() {
    }
}
