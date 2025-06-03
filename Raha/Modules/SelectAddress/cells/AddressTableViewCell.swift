//
//  AddressTableViewCell.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
import CoreLocation
protocol AddressTableViewCellViewCellDelegate: AnyObject {
    func done(wasPressedOnCell cell: AddressTableViewCell , model : AddressesDatum)

}
class AddressTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var defualtHight: NSLayoutConstraint!
    @IBOutlet weak var defualtLbl: UILabel!
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var locTop: NSLayoutConstraint!
    @IBOutlet weak var checkImg: UIImageView!
    var id = 0
    var delegate: AddressTableViewCellViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? AddressesDatum else { return }
//        locLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
        getAddressFromLatLon(latitude: Double(model.lat ?? "0.0") ?? 0.0, longitude: Double(model.lng ?? "0.0") ?? 0.0) { address in
            if let address = address {
                self.locLbl.text = address
            } else {
                print("Unable to get address")
            }
        }
        if model.isDefault ?? 0 == 1 {
            defualtLbl.isHidden = false
            locTop.constant = 8
        }else {
            defualtLbl.isHidden = true
            locTop.constant = 0
        }
        if model.id ?? -1 == id {
            checkImg.image = R.image.checkbox()
            containerView.backgroundColor = R.color.lightblue()
        }else {
            containerView.backgroundColor = R.color.whiteColor()
            checkImg.image = R.image.uncheckedBox()
        }
        containerView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.done(wasPressedOnCell: self, model: model)
        }).store(self)
       
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
