//
//  SupplierFirstScreenViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import CoreLocation
import RSSelectionMenu

protocol ISupplierFirstScreenViewController: class {
	var router: ISupplierFirstScreenRouter? { get set }
    func showresponse(response: [SupplierFirstScreenModel.countries]?)
    func showCity(cities: [SupplierFirstScreenModel.Cities]?)
    func assingNewUser(user: SupplierFirstScreenModel.newUser)
    func navigateToNext(id: Int)
    func alert(title: String, msg: String)

}

class SupplierFirstScreenViewController: UIViewController {
	var interactor: ISupplierFirstScreenInteractor?
	var router: ISupplierFirstScreenRouter?

    
    @IBOutlet weak var nextBTn: UIButton!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var confirmLBL: UILabel!
    @IBOutlet weak var confirmTXT: UITextField!
    @IBOutlet weak var CityTXT: UITextField!
    @IBOutlet weak var createNewAccount: UILabel!
    @IBOutlet weak var AccontLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var supplierNameLBL: UILabel!
    @IBOutlet weak var suppliernameTXT: UITextField!
    @IBOutlet weak var phoneLBL: UILabel!
    @IBOutlet weak var phoneTXT: UITextField!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var AddressTXT: UITextField!
    @IBOutlet weak var CityLBL: UILabel!
    @IBOutlet weak var descriptionCityLBL: UILabel!
    @IBOutlet weak var twonLBL: UILabel!
    @IBOutlet weak var twonTXT: UITextField!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    
    @IBOutlet weak var twon: UILabel!
    
    
    var items: [String] = []
    var value: String = " "
    let tableViewBTN = UIButton(type: .custom)
    let twonTableBTN = UIButton(type: .custom)
    let locManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var selectedCities = [Int]()
    var selectedTwon = [Int]()
    var latitude:String = ""
    var longtidue: String = ""
    var countries  = [SupplierFirstScreenModel.countries]()
    var citiesData = [SupplierFirstScreenModel.Cities]()
    var newUser: SupplierFirstScreenModel.newUser?
    var city_array_data_source: [String] = [String]()
    var selected_cities: [String] = [String]()
    var town_array_data_source: [String] = [String]()
    var selected_twon: [String] = [String]()
    var city_text = ""
    var twon_text = ""
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setcomponets()
        showTableView()
//        addAddress()
        showtwonTable()
        self.interactor?.getcountries()
      
    }
    func setcomponets(){
        
        twon.text = Localization.city + "*"
        AccontLBL.text = Localization.createAccount
        descriptionLBL.text = Localization.accountDescription
        supplierNameLBL.text = Localization.serviceSupplierName + "*"
        phoneLBL.text = Localization.phoneNymber + "*"
        emailLBL.text = Localization.email + "*"
        addressLBL.text = Localization.address + "*"
        CityLBL.text = Localization.Region + "*"
        nextBTn.setTitle(Localization.next, for: .normal)
        password.text = Localization.password + "*"
        confirmLBL.text = Localization.confirmPassword + "*"
        twonLBL.text = Localization.cityDes
        passwordTXT.delegate = self
        twonTXT.delegate = self
        AddressTXT.delegate = self
        suppliernameTXT.delegate = self
        emailTXT.delegate = self
        confirmTXT.delegate = self
        CityTXT.delegate = self
        phoneTXT.delegate = self
        self.navigationItem.title = Localization.newAccount
        AddressTXT.placeholder = Localization.press_location
        CityTXT.placeholder = Localization.press_region
        twonTXT.placeholder = Localization.press_city
        
    }
    
//    func addAddress(){
//        let button2 = UIButton(type: .custom)
//        button2.setImage(UIImage(named: "upload"), for: .normal)
//        button2.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: -10)
//        button2.frame = CGRect(x: CGFloat(AddressTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
//        button2.addTarget(self, action: #selector(self.upload), for: .touchUpInside)
//        AddressTXT.leftView = button2
//        AddressTXT.leftViewMode = .always
//
//    }
//
//    @objc func upload()
//    {
//        get_location()
//    }
    
    func setUpView(){
//        CityTXT.text = value
        locManager.requestWhenInUseAuthorization()
    }
    func get_location()
    {
       if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                if let locationName = placeMark.subLocality {
                self.AddressTXT.text = locationName
                }
            })
            self.latitude = String(describing: latitude)
            self.longtidue = String(describing: longitude)
        }
        
    }
    func showTableView()
    {
      
        tableViewBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        tableViewBTN.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 7)
        tableViewBTN.frame = CGRect(x: CGFloat(CityTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        tableViewBTN.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        
        CityTXT.leftView = tableViewBTN
        CityTXT.leftViewMode = .always
    }
    
    func showtwonTable()
    {
      
        twonTableBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        twonTableBTN.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 7)
        twonTableBTN.frame = CGRect(x: CGFloat(twonTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        twonTableBTN.addTarget(self, action: #selector(self.showtwonTablwViwe), for: .touchUpInside)
        
        twonTXT.leftView = twonTableBTN
        twonTXT.leftViewMode = .always
        
    }
    @objc func showtwonTablwViwe()
    {
        
    }
    
  
    
    @IBAction func refresh(_ sender: Any) {
       
    }
    func validate()
    {
        guard let name = suppliernameTXT.text, !name.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_provider_name, sender: self)
            suppliernameTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
                     
                     return
                 }
                 
                 
        guard let phone = phoneTXT.text, !phone.isEmpty  else {
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_phone, sender: self)
                phoneTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
        
                 return
             }
             
             guard let email = emailTXT.text, !email.isEmpty  else{
                 ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_email, sender: self)
                 emailTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

                 return
             }
             guard let password = passwordTXT.text, !password.isEmpty else{
                 ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_password, sender: self)
                 passwordTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

                 return
             }
             guard let confirm_password = confirmTXT.text, !confirm_password.isEmpty else{
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.confirmed_password, sender: self)
                 confirmTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

                 return
             }
             guard let address = AddressTXT.text, !address.isEmpty else{
                 ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_address, sender: self)
                 AddressTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

                 return
             }
             guard let country = CityTXT.text, !country.isEmpty else{
                 ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_Region, sender: self)
                 CityTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

                 return
             }
        guard let twon = twonTXT.text, !twon.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_City, sender: self)
            twonTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
        
        if password.count < 8{
            showAlert(title: Localization.errorLBL, msg: Localization.password_conut)
        }
        else if phone.count == 11{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.phone_count, sender: self)
        }
       else if password != confirm_password{
        ShowAlertView.showAlert(title: Localization.incorrectPassword, msg: Localization.incorrectPassword, sender: self)
                }
        else{

            interactor?.register(name: name, email: email, phone: phone, country_code: "+20", type: "provider", accepted: true, password: password, city_ids: selectedTwon, address: address, latitude: latitude, longitude: longtidue)

                }
        
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        validate()


    }
    
}

extension SupplierFirstScreenViewController{
    }
    


extension SupplierFirstScreenViewController: ISupplierFirstScreenViewController {
    func alert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }

    func navigateToNext(id: Int) {
        router?.goNext(id: id)
    }
    
    func assingNewUser(user: SupplierFirstScreenModel.newUser) {
        self.newUser = user
    }
    
    func showCity(cities: [SupplierFirstScreenModel.Cities]?) {
        guard let response = cities else {return}
        citiesData = response
        town_array_data_source.removeAll()
        for item in citiesData{
            self.town_array_data_source.append(item.name ?? "")
        }
        
    }
    
    func showresponse(response: [SupplierFirstScreenModel.countries]?) {
        guard let response = response else {return}
        countries = response
        print("response\(countries)")
        city_array_data_source.removeAll()
        for item in countries{
            self.city_array_data_source.append(item.name ?? "")
        }
        }
    }

extension SupplierFirstScreenViewController {
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
}

extension SupplierFirstScreenViewController {
    func get_data(array: [String], textField: UITextField )
    {
        
        if textField == CityTXT{
            city_array_data_source.removeAll()
            for item in array{
                city_array_data_source.append(item)
            }
            

            let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: city_array_data_source) { (cell, name, indexpath) in
                       cell.textLabel?.text = name
                   }
                   menu.setSelectedItems(items: selected_cities) {[weak self] (item, index, isselected, selectedItem) in
                       self?.selected_cities = selectedItem
                       
                   }
                   menu.cellSelectionStyle = .checkbox
                   
            menu.show(style: .alert(title: Localization.select_city , action: "ok", height: 300.0), from: self)
                  
                   menu.onDismiss = { [weak self] items in
                       self?.selected_cities = items
                    var indexes: [Int] = [Int]()
                    var insed: Int?
                    for item in 0..<self!.selected_cities.count{
                    for _ in 0..<self!.countries.count{
                         insed = self?.countries.index(where: {$0.name == self?.selected_cities[item]})
                    }
                        indexes.append(insed!)
                        self?.city_text.append(contentsOf: self?.selected_cities[item] ?? "")
                        self?.city_text.append(contentsOf: " ")

                    }
                    for i in 0..<indexes.count{
                        self?.selectedCities.append((self?.countries[indexes[i]].id)!)
                    }
                    if self?.selectedCities.count != 0{
                    if let cities_id = self?.selectedCities{
                       self?.interactor?.getCities(countries: cities_id)
                    }
                    }

                    self?.CityTXT.text = self?.city_text
        }
        }
        else{
            for item in array{
                town_array_data_source.append(item)
            }

            let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: town_array_data_source) { (cell, name, indexpath) in
                       cell.textLabel?.text = name
                   }
                   menu.setSelectedItems(items: selected_twon) {[weak self] (item, index, isselected, selectedItem) in
                       self?.selected_twon = selectedItem
                       
                   }
                   menu.cellSelectionStyle = .checkbox
                   
            menu.show(style: .alert(title: Localization.select_twon, action: "ok", height: 300.0), from: self)
                  
                   menu.onDismiss = { [weak self] items in
                       self?.selected_twon = items
                    var indexes: [Int] = [Int]()
                    var insed: Int?
                    for item in 0..<self!.selected_twon.count{
                    for _ in 0..<self!.citiesData.count{
                        insed = self?.citiesData.index(where: {$0.name == self?.selected_twon[item]})
                    }
                        
                        indexes.append(insed!)
                        self?.twon_text.append(contentsOf: self?.selected_twon[item] ?? "")
                        self?.twon_text.append(contentsOf: " ")


                    }
                    for i in 0..<indexes.count{
                        self?.selectedTwon.append((self?.citiesData[indexes[i]].id)!)
                    }
                    
                    self?.twonTXT.text = self?.twon_text
                    
        }
    
    
             
    }
    }
	// do someting...
}
extension SupplierFirstScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if textField == CityTXT{
            get_data(array: city_array_data_source, textField: CityTXT)
          return false
        }
        else if textField == twonTXT{
            print("ssss\(CityTXT.text)")
            if CityTXT.text?.isEmpty == true {
                print("empy\ty")
                    ShowAlertView.showAlert(title: "", msg: Localization.choose_regin, sender: self)
                
            }
            else
            {
                get_data(array: town_array_data_source, textField: twonTXT)

            }

           return false
        }
        else if textField == AddressTXT{
            get_location()
            return false
        }
        
        return true
    }
    // do someting...
}


