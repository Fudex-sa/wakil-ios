//
//  AddresslistTableViewCell.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
import CoreLocation
protocol AddresslistTableViewCellDelegate: AnyObject {
    func edit(wasPressedOnCell cell: AddresslistTableViewCell , model : AddressesDatum)
    func delete(wasPressedOnCell cell: AddresslistTableViewCell , model : AddressesDatum)
    func defult(wasPressedOnCell cell: AddresslistTableViewCell , model : AddressesDatum)

}
class AddresslistTableViewCell: BaseTableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var defualtLbl: UILabel!
    @IBOutlet weak var defultBtn: UIButton!
    var delegate: AddresslistTableViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? AddressesDatum else { return }
//        titleLbl.text = "\(model.district ?? "") - \(model.cityID?.name ?? "") - \(model.stateID?.name ?? "")"
//        getAddressFromLatLon(latitude: Double(model.lat ?? "0.0") ?? 0.0, longitude: Double(model.lng ?? "0.0") ?? 0.0) { address in
//            if let address = address {
//                self.titleLbl.text = address
//            } else {
//                print("Unable to get address")
//            }
//        }
        if model.isDefault ?? 0 == 1 {
            deleteBtn.isHidden = true
            defualtLbl.isHidden = false
            defultBtn.setImage(R.image.toggle(), for: .normal)
        }else {
            deleteBtn.isHidden = false
            defualtLbl.isHidden = true
            defultBtn.setImage(R.image.toggle2(), for: .normal)
        }
        editBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.edit(wasPressedOnCell: self, model: model)
        }).store(self)
        deleteBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.delete(wasPressedOnCell: self, model: model)
        }).store(self)
        defultBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.defult(wasPressedOnCell: self, model: model)
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
