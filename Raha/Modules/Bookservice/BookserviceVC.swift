//
//  BookserviceVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - ...  ViewController - Vars
class BookserviceVC: BaseController {
    @IBOutlet weak var giftcheckView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var noAppointmentLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var slotsTbl: UITableView!
    @IBOutlet weak var calenderView: HorizontalCalendarView!
    @IBOutlet weak var addGiftBtn: UIButton!
    @IBOutlet weak var changeAddressBtn: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var visitLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var vatTitleLbl: UILabel!
    @IBOutlet weak var vatLbl: UILabel!

    @IBOutlet weak var serviceTbl: UITableView!
    var viewModel: BookserviceViewModel?
    var coordinator: BookserviceCoordinator?
    var centerId = 0
    var loctype = ""
    var selectservices : [Service] = []
    var slots : [SlotsDatum] = []
    var address: AddressesDatum?
    var date = ""
    var payTaps: PayTaps?
    var suucesUrl = ""
    var failedurl = ""
}

// MARK: - ...  LifeCycle
extension BookserviceVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        date = DateHelper().currentDate() ?? ""
        viewModel = .init()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator = nil
        viewModel?.createorder = .init()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.slotsdetails.listen(on: { [weak self] value in
            self?.slots.removeAll()
            self?.slots.append(contentsOf: self?.viewModel?.slotsdetails.value?.data ?? [])
            if self?.viewModel?.slotsdetails.value?.data?.count ?? 0 == 0 {
                self?.noAppointmentLbl.isHidden = false
            }else {
                self?.noAppointmentLbl.isHidden = true
            }
            self?.vatTitleLbl.text = "\("Vat".localized) \(self?.viewModel?.slotsdetails.value?.vat_rate ?? "") % :"
            self?.vatLbl.text = self?.viewModel?.slotsdetails.value?.vat_amount?.string ?? ""
            self?.priceLbl.text = self?.viewModel?.slotsdetails.value?.sub_total?.string ?? ""
            self?.slotsTbl.reloadData()
        })
        viewModel?.createorder.listen(on: { [weak self] value in
            self?.stopLoading()
            self?.suucesUrl = self?.viewModel?.createorder.value?.data?.successURL ?? ""
            self?.failedurl = self?.viewModel?.createorder.value?.data?.failURL ?? ""
            self?.payTaps = .init(dataSource: self)
            self?.payTaps?.delegate = self
            self?.payTaps?.present(in: self)
        })
        viewModel?.checkaddress.listen(on: { [weak self] value in
            if self?.viewModel?.name.value ?? "" != "" {
                self?.checkView.isHidden = true
                if self?.viewModel?.checkaddress.value?.status ?? false {
                    self?.giftcheckView.isHidden = true
                }else {
                    self?.giftcheckView.isHidden = false
                }
            }else {
                self?.giftcheckView.isHidden = true
                if self?.viewModel?.checkaddress.value?.status ?? false {
                    self?.checkView.isHidden = true
                }else {
                    self?.checkView.isHidden = false
                }
            }
        })
       
    }
}
// MARK: - ...  Functions
extension BookserviceVC {
    func setup() {
        if address == nil {
            address = UD.address
        }
        serviceTbl.skeleton()
        serviceTbl.delegate = self
        serviceTbl.dataSource = self
        serviceTbl.observe()
        slotsTbl.skeleton()
        slotsTbl.delegate = self
        slotsTbl.dataSource = self
        slotsTbl.observe()
        viewModel?.centerId.send(centerId)
        viewModel?.services.send(selectservices)
        viewModel?.date.send(date)
        viewModel?.fetchcentersdetails()
        if loctype == "home" {
            visitLbl.text = "Home visit".localized
            addressView.isHidden = false
            if UD.address != nil {
                viewModel?.lat.send(Double(UD.address?.lat ?? "0.0") ?? 0.0)
                viewModel?.lng.send(Double(UD.address?.lng ?? "0.0") ?? 0.0)
                viewModel?.fetchcheckaddress()
            }
        }else {
            visitLbl.text = "At the center".localized
            addressView.isHidden = true
        }
        if address != nil {
//            addressLbl.text = "\(address?.district ?? "") - \(address?.cityID?.name ?? "") - \(address?.stateID?.name ?? "")"
            getAddressFromLatLon(latitude: Double(address?.lat ?? "0.0") ?? 0.0, longitude: Double(address?.lng ?? "0.0") ?? 0.0) { address in
                if let address = address {
                    self.addressLbl.text = address
                } else {
                    print("Unable to get address")
                }
            }
            changeAddressBtn.setTitle("Change".localized, for: .normal)
        }else {
            addressLbl.text = "Addresses list is empty".localized
            changeAddressBtn.setTitle("Add".localized, for: .normal)
        }
        var price = 0.0
        for index in selectservices {
            price = price + Double(index.price ?? "0.0")!
        }
        priceLbl.text = price.string ?? ""
        serviceTbl.reloadData()
        calenderView.onDateSelected = { selectedDate in
            print("You picked: \(selectedDate)")
            self.date = DateHelper().date(date: selectedDate, format: "dd-MM-yyyy") ?? ""
            self.viewModel?.date.send(self.date ?? "")
            self.viewModel?.fetchcentersdetails()
        }
        changeAddressBtn.publisher.listen(on: {[weak self] _ in
            if UD.address == nil {
                self?.coordinator?.addaddress()
            }else {
                self?.coordinator?.selectaddress()
            }
        }).store(self)
        addGiftBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.gift()
        }).store(self)
        calenderView.calendarIcon.UIViewAction {
            self.coordinator?.calender()
        }
        bookBtn.publisher.listen(on: {[weak self] _ in
            var error = ""
            if self?.slots.count == 0 {
                error = "no available appountment".localized
            }
            if self?.loctype != "center" && self?.address?.id ?? 0 == 0 {
                error = "\(error) \("Add address".localized)\n"
            }
            if self?.viewModel?.checkaddress.value?.status ?? true == false {
                error = "\(error) \("Address is out of range".localized)\n"
            }
            for index in self?.slots ?? [] {
                var isgood = false
                for item in index.slots ?? [] {
                    if item.isselect ?? false == true {
                        isgood = true
                    }
                }
                if isgood == false {
                    error = "\(error) \("Service that name is".localized) \(index.serviceName ?? "") \("not select time to reseve".localized)\n"
                }
            }
            if error == "" {
                self?.viewModel?.location_type.send(self?.loctype ?? "")
                self?.viewModel?.address_id.send(self?.address?.id ?? 0)
                self?.viewModel?.payment_method.send("visa")
                self?.viewModel?.price.send(self?.priceLbl.text ?? "")
                self?.viewModel?.slots.send(self?.slots ?? [])
                self?.viewModel?.makecreateorder()
            }else {
                self?.didError(error: error)
            }
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
// MARK: - ...  View Contract
extension BookserviceVC {
}
extension BookserviceVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == slotsTbl {
            return slots.count
        }else {
            return selectservices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == slotsTbl {
            var cell = tableView.cell(type: ServicesslotsTableViewCell.self, indexPath)
            cell.model = slots[safe: indexPath.row]
            cell.delegate = self
            return cell
        }else {
            var cell = tableView.cell(type: SelectservicesTableViewCell.self, indexPath)
            cell.model = selectservices[safe: indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
extension BookserviceVC : ServicesslotsTableViewCellDelegate {
    func selectservice(wasPressedOnCell cell: ServicesslotsTableViewCell, model: SlotsDatum) {
        var index1 = 0
        for index in slots {
            if index.serviceID == model.serviceID {
                if slots[index1].isselect ?? false == false {
                    slots[index1].isselect = true
                }else {
                    slots[index1].isselect = false
                }
            }
            index1 = index1 + 1
        }
        slotsTbl.reloadData()
    }
    
    func selectslot(wasPressedOnCell cell: ServicesslotsTableViewCell, model: [Slot], serviceId : Int) {
        var index1 = 0
        for index in slots {
            if index.serviceID == serviceId {
                slots[index1].slots?.removeAll()
                slots[index1].slots?.append(contentsOf: model)
            }
            index1 = index1 + 1
        }
        slotsTbl.reloadData()
    }
    
    
}
extension BookserviceVC: PayTapsDelegate, PayTapsDataSource {
    func payTaps(_ payTaps: PayTaps?, didPay orderID: Int) {
        coordinator?.paymentdone()
    }
    func payTaps(_ payTaps: PayTaps?, cancel pay: Bool) {
        NotificationBuilder().setTitle("Info".localized).setBody("You are cancelled the payment process".localized).setTheme(.info).bulid()
    }
    func payTaps(_ payTaps: PayTaps?, fail pay: Bool) {
        super.didError(error: "Online payment has been made a mistake please try again".localized)
    }
    
    func payTaps(_ payTaps: PayTaps?, successURL: Bool?) -> String? {
        return suucesUrl
    }
    
    func payTaps(_ payTaps: PayTaps?, failURL: Bool?) -> String? {
        return failedurl
    }
    
    func payTaps(_ payTaps: PayTaps?, URL: Bool?) -> String? {
        return viewModel?.createorder.value?.data?.paymentURL ?? ""
    }
}
