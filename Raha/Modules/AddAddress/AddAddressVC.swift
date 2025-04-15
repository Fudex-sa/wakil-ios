//
//  AddAddressVC.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - ...  ViewController - Vars
class AddAddressVC: BaseController {
    @IBOutlet weak var locLbl: UILabel!
    @IBOutlet weak var locView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var defaultBtn: CheckBoxButton!
    @IBOutlet weak var hayTxf: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var streetTxf: UITextField!
    var viewModel: AddAddressViewModel?
    var coordinator: AddAddressCoordinator?
    var isedit = false
    var address : AddressesDatum?
    lazy var validator: Validator? = {
        let validator = Validator(guardOnSuperViewOfTextField: true)
        validator.setUIType(.message).append(streetTxf, rules: [GuardRequired()], title: "Street".localized).holdColor()
        validator.setUIType(.message).append(hayTxf, rules: [GuardRequired() ], title: "Neighborhood".localized).holdColor()
        return validator
    }()
    var isfirst = false
}

// MARK: - ...  LifeCycle
extension AddAddressVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
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
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.statesFinished.listen(on: { [weak self] value in
            self?.stopLoading()
        })
        viewModel?.citiesFinished.listen(on: { [weak self] value in
            self?.stopLoading()
        })
        viewModel?.addressdata.listen(on: { [weak self] value in
            if self?.isfirst == true {
                UD.address = self?.viewModel?.addressdata.value?.data
            }
            self?.navigationController?.popViewController(animated: true)
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.addressdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()

        })
        viewModel?.editsdata.listen(on: { [weak self] value in
            self?.navigationController?.popViewController(animated: true)
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.addressdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()

        })
    }
}
// MARK: - ...  Functions
extension AddAddressVC {
    func setup() {
        if isedit {
            viewModel?.addressId.send(address?.id ?? 0)
            streetTxf.text = address?.street ?? ""
            hayTxf.text = address?.district ?? ""
            cityLbl.text = address?.cityID?.name ?? ""
            regionLbl.text = address?.stateID?.name ?? ""
            viewModel?.street.send(address?.street ?? "")
            viewModel?.district.send(address?.district ?? "")
            viewModel?.statesId.send(address?.stateID?.id ?? 0)
            viewModel?.city_id.send(address?.cityID?.id ?? 0)
            viewModel?.lat.send(address?.lat ?? "")
            viewModel?.lng.send(address?.lng ?? "")
            cityLbl.textColor = R.color.black1()
            regionLbl.textColor = R.color.black1()
            locLbl.textColor = R.color.black1()
            if address?.isDefault ?? 0 == 1 {
                defaultBtn.isOn = true
                viewModel?.is_default.send(1)
            }else {
                defaultBtn.isOn = false
                viewModel?.is_default.send(0)
            }
            if address?.lat ?? "" != "" {
                reverseGeocode(lat: address?.lat?.double() ?? 0, lng: address?.lng?.double() ?? 0)
            }
            viewModel?.fetchcities()

        }
        startLoading()
        viewModel?.fetchstates()
        regionView.publisherGesture.listen(on: {[weak self] _ in
            self?.pickstates()
        }).store(self)
        cityView.publisherGesture.listen(on: {[weak self] _ in
            if self?.viewModel?.statesId.value ?? 0 == 0 {
                self?.didError(error: "select Region first".localized)
                return
            }
            self?.pickcities()
        }).store(self)
        locView.publisherGesture.listen(on: {[weak self] _ in
            self?.coordinator?.locate()
        }).store(self)
        saveBtn.publisher.listen(on: {[weak self] _ in
            if self?.validator?.build() == false {
                return
            }
            var error = ""
            if self?.viewModel?.statesId.value ?? 0 == 0 {
                error = "\(error)\n\("select Region".localized)"
            }
            if self?.viewModel?.city_id.value ?? 0 == 0 {
                error = "\(error)\n\("select City".localized)"
            }
            if self?.viewModel?.lat.value ?? "" == "" {
                error = "\(error)\n\("select Location".localized)"
            }
            if error != "" {
                self?.didError(error: error)
            }else {
                self?.viewModel?.street.send(self?.streetTxf.text ?? "")
                self?.viewModel?.district.send(self?.hayTxf.text ?? "")
                self?.startLoading()
                if self?.defaultBtn.isOn == false {
                    self?.viewModel?.is_default.send(0)
                }else {
                    self?.viewModel?.is_default.send(1)
                }
                if self?.isedit ?? false {
                    self?.viewModel?.editaddress()
                }else {
                    self?.viewModel?.addaddress()
                }
            }
        }).store(self)
    }
    func pickstates() {
        let scene = SearchViewPicker(nib: R.nib.searchViewPicker)
        scene.pickTitle.send("Region".localized)
        scene.source = viewModel?.states.value ?? []
        scene.didSelectItem.listen(on: { [weak self] didSelect in
            guard let item = didSelect?.1 as? RegisterModel else { return }
            self?.regionLbl.text = item.name ?? ""
            self?.regionLbl.textColor = R.color.black1()
            self?.cityLbl.text = "City".localized
            self?.cityLbl.textColor = R.color.black3()
            self?.viewModel?.city_id.send(0)
            self?.startLoading()
            self?.viewModel?.statesId.send(item.id ?? 0)
            self?.viewModel?.fetchcities()
        })
        self.pushPop(scene)
    }
    func pickcities() {
        let scene = SearchViewPicker(nib: R.nib.searchViewPicker)
        scene.pickTitle.send("City".localized)
        scene.source = viewModel?.cities.value ?? []
        scene.didSelectItem.listen(on: { [weak self] didSelect in
            guard let item = didSelect?.1 as? RegisterModel else { return }
            self?.cityLbl.text = item.name ?? ""
            self?.cityLbl.textColor = R.color.black1()
            self?.viewModel?.city_id.send(item.id ?? 0)
        })
        self.pushPop(scene)
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
                self?.locLbl.text = address
                self?.locLbl.textColor = R.color.black1()
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
// MARK: - ...  View Contract
extension AddAddressVC {
}
