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
    @IBOutlet weak var cityTable: UITableView!
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
    @IBOutlet weak var townTbale: UITableView!
    @IBOutlet weak var cityTableHight: NSLayoutConstraint!
    @IBOutlet weak var twonHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    
    var items: [String] = []
    var value: String = " "
    var showTable = false
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
    var selectedCountries = Array<Int>(repeating: 0, count: 15)
    var newUser: SupplierFirstScreenModel.newUser?
    var type: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setcomponets()
        showTableView()
        addAddress()
        showtwonTable()
        self.interactor?.getcountries()
      
    }
    func setcomponets(){
         print("Type\(type)")
        createNewAccount.text = Localization.newAccount
        AccontLBL.text = Localization.createAccount
        descriptionLBL.text = Localization.accountDescription
        supplierNameLBL.text = Localization.serviceSupplierName + "*"
        phoneLBL.text = Localization.phoneNymber + "*"
        emailLBL.text = Localization.email + "*"
        addressLBL.text = Localization.address + "*"
        CityLBL.text = Localization.city + "*"
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
        
    }
    
    func addAddress(){
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "upload"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        button2.frame = CGRect(x: CGFloat(AddressTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button2.addTarget(self, action: #selector(self.upload), for: .touchUpInside)
        AddressTXT.leftView = button2
        AddressTXT.leftViewMode = .always
        
    }
    
    @objc func upload()
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
    
    func setUpView(){
        cityTable.dataSource = self
        cityTable.delegate = self
        townTbale.delegate = self
        townTbale.dataSource = self
        CityTXT.text = value
        cityTable.isHidden = true
        townTbale.isHidden = true
        locManager.requestWhenInUseAuthorization()
        cityTable.rowHeight = 50
        let nib = UINib(nibName: "CityCellTableViewCell" , bundle: nil)
        cityTable.register(nib, forCellReuseIdentifier: "hamada")
        let nib1 = UINib(nibName: "TableViewCell", bundle: nil)
        townTbale.register(nib1, forCellReuseIdentifier: "city2Cell")
        
        
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
        if townTbale.isHidden == true{
            twonTableBTN.setImage(UIImage(named: "upArrow"), for: .normal)
            townTbale.isHidden = false
            townTbale.reloadData()
            
        }
        else{
            twonTableBTN.setImage(UIImage(named: "downArrow"), for: .normal)
            
            townTbale.isHidden = true
            townTbale.reloadData()
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func refresh(_ sender: Any) {
        if cityTable.isHidden == true{
            tableViewBTN.setImage(UIImage(named: "upArrow"), for: .normal)
            cityTable.isHidden = false
cityTable.reloadData()

        }
        else{
            tableViewBTN.setImage(UIImage(named: "downArrow"), for: .normal)

            cityTable.isHidden = true
            cityTable.reloadData()

        }
    }
    
    @IBAction func nextBTN(_ sender: Any) {
        guard let name = suppliernameTXT.text,
            let phone = phoneTXT.text,
            let password1 = passwordTXT.text,
            let password2 = confirmTXT.text,
            let email = emailTXT.text,
            let address = AddressTXT.text
            else{
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
                return
        }
        
        if password1 != password2{
            ShowAlertView.showAlert(title: Localization.incorrectPassword, msg: Localization.incorrectPassword, sender: self)
        }
        else{
            interactor?.register(name: name, email: email, phone: phone, country_code: "+20", type: "provider", accepted: true, password: password1, city_ids: selectedTwon, address: address, latitude: latitude, longitude: longtidue)
        }
 
        
    }
    
}

extension SupplierFirstScreenViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == cityTable{
        return countries.count
        }
        else
        {
            return citiesData.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == cityTable{
        if cityTable.isHidden == true{
            self.cityTableHight.constant = 0
            return 0
        }
        else{
            self.cityTableHight.constant = 150
            return 1
        }
        }
        else{

            if townTbale.isHidden == true{
                self.twonHeight.constant = 0
                return 0
            }
            else{
                self.twonHeight.constant = 150
                return 1
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == cityTable{
        let cell = tableView.dequeueReusableCell(withIdentifier: "hamada", for: indexPath) as! CityCellTableViewCell
        cell.city.text = countries[indexPath.row].name
            cell.selectionStyle = .none
            
        return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "city2Cell", for: indexPath) as! TableViewCell
            cell.cityLBL.text = citiesData[indexPath.row].name
            cell.selectionStyle = .none
        
            return cell
        }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == cityTable{
            if let cell = tableView.cellForRow(at: indexPath){
                cell.isSelected = true
                selectedCities.append(countries[indexPath.row].id!)
            }
            self.interactor?.getCities(countries: selectedCities)
            townTbale.reloadData()
            }
    
        else {
            if let cell = tableView.cellForRow(at: indexPath){
            cell.isSelected = true
                selectedTwon.append(citiesData[indexPath.row].id!)
                
            }
                }
        }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == cityTable{
            if let cell = tableView.cellForRow(at: indexPath){
                cell.isSelected = false
                }
        }
            else{
                
                if let cell = townTbale.cellForRow(at: indexPath){
                cell.isSelected = false
    
    }
                
            }
        }
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
        
        townTbale.reloadData()
    }
    
    func showresponse(response: [SupplierFirstScreenModel.countries]?) {
        guard let response = response else {return}
        countries = response
        cityTable.reloadData()
    }
    
	// do someting...
}

extension SupplierFirstScreenViewController {
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
}

extension SupplierFirstScreenViewController {
	// do someting...
}
extension SupplierFirstScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    // do someting...
}


