//
//  LocationHelperDelegate.swift
//  BaseIOS
//
//  Created by Mabdu on 03/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

typealias OnUpdateLocation = ((CLLocationCoordinate2D?) -> Void)
typealias OnErrorLocation = (() -> Void)

protocol LocationDelegate: AnyObject {
    func location(_ locationHelper: LocationHelper?, lat: Double, lng: Double)
    func location(_ locationHelper: LocationHelper?, didError: Bool)
}
extension LocationDelegate {
    func location(_ locationHelper: LocationHelper?, lat: Double, lng: Double) { }
    func location(_ locationHelper: LocationHelper?, didError: Bool) { }
}
