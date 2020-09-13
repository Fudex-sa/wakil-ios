//
//  addrequestViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import  RSSelectionMenu
protocol IaddrequestViewController: class {
	var router: IaddrequestRouter? { get set }
    func assignorganization(organizations: [addrequestModel.Organization])
    func assignCountries(countries: [addrequestModel.Organization])
    func assignCities(cities: [addrequestModel.Organization])
    func assign_reqesut(request: editModel.edit)
    func backToHome()
    
}

class addrequestViewController: UIViewController {
	var interactor: IaddrequestInteractor?
	var router: IaddrequestRouter?

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var HomeLBL: UILabel!
    @IBOutlet weak var addREQ: UILabel!
    @IBOutlet weak var addReqDES: UILabel!
    @IBOutlet weak var addReqDES2: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descripeReQ: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var regionTXT: UITextField!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityTEX: UITextField!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressDES: UILabel!
    @IBOutlet weak var addressTEX: UITextField!
    @IBOutlet weak var minstryLBL: UILabel!
    @IBOutlet weak var minstryDES: UILabel!
    @IBOutlet weak var minstryTxt: UITextField!
    @IBOutlet weak var achieveLBL: UILabel!
    @IBOutlet weak var achieveTXT: UITextField!
    @IBOutlet weak var sendBTN: UIButton!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var titleTXT: UITextField!
    
    let regionBTN = UIButton(type: .custom)
    let cityBTN = UIButton(type: .custom)
    let addressBTN = UIButton(type: .custom)
    let minstryBTN = UIButton(type: .custom)
    let achieveBTN = UIButton(type: .custom)
    var gatData: formatData = formatData()
    var selected_Org_Id: Int = Int()
    var countries: [addrequestModel.Organization]?
    var cities: [addrequestModel.Organization]?
    var organizations: [addrequestModel.Organization]?
    var selectedEmail = ""
    var organizationName: [String] = [String]()

    
    
    var selectedOrgName: [String] = [String]()
    var selectedOrgId: [Int] = [Int]()
    var selected_Country_ID: Int = Int()
    var seleted_City_ID: Int = Int()
    var seleted_organization_ID: Int = Int()
    var type = ""
    var cities1: [addrequestModel.Organization]?
    var interActor = getCities()
    var provementsEmails: [String] = [String(Localization.email2), String(Localization.Registered_Mail),String(Localization.Excellent_email)]
    var selectedEmails: [String] = [String]()
    var selectedEmail1 = ""
    var selected_Conutry_Name = ""
    var selected_City_Name = ""
    var selected_organization_Name = ""
    var selected_Email_Name = ""
    var edit_request: editModel.edit?
    var provider_id: Int?
    var advertizing_id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        self.hideKeyboardWhenTappedAround()
        showCity()
        showachieve()
        showminstry()
        showregions()
        getOrganization()
        addTapGuester()
        getCountries()
        
    }
    
    
    
    func addTapGuester()
    {
      regionTXT.delegate = self
        cityTEX.delegate = self
        minstryTxt.delegate = self
        addressTEX.delegate = self
        achieveTXT.delegate = self
        
    }
 
    func setUpView()
    {
        
        addREQ.text = Localization.addRequest
        addReqDES.text = Localization.RequestDes
        addressDES.text = Localization.RequestDes
        descripeReQ.text = Localization.characterCount
        addReqDES2.text = Localization.RequestDEs2 + "*"
        region.text = Localization.selectRegion + "*"
        city.text = Localization.chooseCit + "*"
        address.text = Localization.authority + "*"
        addressDES.text = Localization.neighborhood
        minstryLBL.text = Localization.ministry + "*"
        minstryDES.text = Localization.agency
        achieveLBL.text = Localization.achievement + "*"
        titleLBL.text = Localization.title_of_service
        sendBTN.setTitle(Localization.send, for: .normal)
        textView.delegate = self
        self.navigationItem.title = Localization.addRequest
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topView"), for: UIBarMetrics.default)
        
    }
    
    func showregions()
    {
        
        regionBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        regionBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        regionBTN.frame = CGRect(x: CGFloat(regionTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        regionBTN.addTarget(self, action: #selector(self.getRegions), for: .touchUpInside)
        
        regionTXT.leftView = regionBTN
        regionTXT.leftViewMode = .always
    }
    
    
    
    func showCity(){
        cityBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        cityBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        cityBTN.frame = CGRect(x: CGFloat(cityTEX.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        cityBTN.addTarget(self, action: #selector(self.get_city), for: .touchUpInside)
        
        cityTEX.leftView = cityBTN
        cityTEX.leftViewMode = .always
    }

    func showminstry(){
        minstryBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        minstryBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        minstryBTN.frame = CGRect(x: CGFloat(minstryTxt.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        minstryBTN.addTarget(self, action: #selector(self.get_organiziation), for: .touchUpInside)
        
        minstryTxt.leftView = minstryBTN
        minstryTxt.leftViewMode = .always
        
    }
    func showachieve(){
        achieveBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        achieveBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        achieveBTN.frame = CGRect(x: CGFloat(achieveTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        achieveBTN.addTarget(self, action: #selector(self.get_provemnets_email), for: .touchUpInside)
        
        achieveTXT.leftView = achieveBTN
        achieveTXT.leftViewMode = .always
        
    }
    
   
    @IBAction func backBTN(_ sender: Any) {

        dismiss()

    }
    
    @IBAction func sendBTN(_ sender: Any) {
     
        validateData()
        
        
    }
    func getOrganization(){
      self.interactor?.getorganzation()
        
        
    }
    func getCountries()
    {
       self.interactor?.getCountries()
    }
   
    
    func validateData(){
            
            guard let titleText = titleTXT.text, !titleText.isEmpty else{
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.title_of_service, sender: self)
                titleTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
                
                return
            }
            
            
        guard let des = textView.text, !des.isEmpty || des.count < 360 else {
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_DES, sender: self)
            return
        }
        
        guard let region = regionTXT.text, !region.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_Region, sender: self)
            regionTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
        guard let city = cityTEX.text, !city.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_City, sender: self)
            cityTEX.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
        guard let address = addressTEX.text, !address.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_authority, sender: self)
            addressTEX.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
        guard let minstray = minstryTxt.text, !minstray.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_minstry, sender: self)
            minstryTxt.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
        guard let provement = achieveTXT.text, !provement.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_provement, sender: self)
            achieveTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])

            return
        }
            
       
            let description = textView.text!
//            let addres = addressTEX.text!
            if let providerID = provider_id,let advertizingID = advertizing_id {
                self.interactor?.add_special_request(title: titleText, description: description, country_id: self.selected_Country_ID, city_id: self.seleted_City_ID, organization_id: selected_Org_Id, address: address, achievement_proof: self.selectedEmail, provider_id: providerID, ads_id: advertizingID)

                
            }
            else{
                self.interactor?.addreuest(title: titleText, description: description, country_id: self.selected_Country_ID, city_id: self.seleted_City_ID, organization_id: selected_Org_Id, address: address, achievement_proof: self.selectedEmail)

            }
            
            
            
            
    }
    
}

extension addrequestViewController: IaddrequestViewController {
    func assign_reqesut(request: editModel.edit) {
        self.edit_request = request
    }
    
   
    func backToHome() {
        self.navigate(type: .modal, module: GeneralRouterRoute.Home, completion: nil)
    }
    
    
    
    
    func assignCountries(countries: [addrequestModel.Organization]) {
        self.countries = countries
    }
    
    func assignCities(cities: [addrequestModel.Organization]) {
//        self.cities = cities
    }
    
    
    func assignorganization(organizations: [addrequestModel.Organization]) {
        self.organizations = organizations
    }
    
	// do someting...
}


extension addrequestViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{

        if textField == regionTXT{
            
            self.type = "countries"
            if let cities = countries{
                self.getOrganization1(organizations: cities, view: self)

            }
          return false
        }
        else if textField == cityTEX{
            self.type = "cities"

            if regionTXT.text?.isEmpty == true{
                ShowAlertView.showAlert(title: "", msg: Localization.choose_regin, sender: self)
            }
            else {
                if let cities = cities1{
                    self.getOrganization1(organizations: cities, view: self)
                }
            }
            
            return false
        }
        else if textField == minstryTxt{
        self.type = "organization"
            if let cities = organizations{
                self.getOrganization1(organizations: cities, view: self)
            }
          return false
        }
       else if textField == achieveTXT{
            self.getProveEmails()
            return false
        }
        else {
            return true
            
        }
        
        
      
    }
    
    
    
    
}
extension addrequestViewController{
    
    
    @objc func getRegions()
    {
        self.type = "countries"
        if let country = countries{
            self.getOrganization1(organizations: country, view: self)
            
        }
    }
    
    @objc func get_city()
    {
        self.type = "cities"
        
        if let cities = cities1{
            self.getOrganization1(organizations: cities, view: self)
        
        }
    }
    
    @objc func get_organiziation()
    {
    self.type = "organization"
      if let orgs = organizations{
        self.getOrganization1(organizations: orgs, view: self)
    }
        
    }
    @objc func get_provemnets_email()
    {
      getProveEmails()
        
    }
    
    func getProveEmails()
    {
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: provementsEmails) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selectedEmails) {[weak self] (item, index, isselected, selectedItem) in
            self?.selectedEmails = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: Localization.select_email, action: Localization.ok, height: 300.0), from: self)
        menu.onDismiss = { [weak self] items in
            self?.selectedEmail = (self?.selectedEmails[0])!
            self?.achieveTXT.text = (self?.selectedEmails[0])!
            
            
        }
    }
    
}
extension addrequestViewController: UITextViewDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count < 360
    }
    func getOrganization1(organizations: [addrequestModel.Organization], view: UIViewController)
    {
        organizationName.removeAll()
        
        
        for item in organizations{
            organizationName.append(item.name!)
        }
        
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: organizationName) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selectedOrgName) {[weak self] (item, index, isselected, selectedItem) in
            self?.selectedOrgName = selectedItem
            
        }
        menu.cellSelectionStyle = .checkbox
        if self.type == "organization" {
             menu.show(style: .alert(title: "organization", action: "ok", height: 300.0), from: view)
        }
        else if self.type == "countries" {
            menu.show(style: .alert(title: Localization.select_city, action: "ok", height: 300.0), from: view)
            
        }
        else if self.type == "cities" {
            menu.show(style: .alert(title: Localization.select_twon, action: "ok", height: 300.0), from: view)
            
        }
       
       
        menu.onDismiss = { [weak self] items in
            self?.selectedOrgName = items
            var indexes: [Int] = [Int]()
            for item in 0..<self!.selectedOrgName.count{
                let insed = organizations.index(where: {$0.name == self?.selectedOrgName[item]})
                indexes.append(insed!)
                
            }
            
            
            switch self?.type {
            case "organization":
                self?.selected_Org_Id = organizations[indexes[0]].id!
                self?.selected_organization_Name = organizations[indexes[0]].name!
                self?.minstryTxt.text = self?.selected_organization_Name
                
                
            case "countries":
                self?.selected_Country_ID = organizations[indexes[0]].id!
                self?.selected_Conutry_Name = organizations[indexes[0]].name!
                self?.regionTXT.text = self?.selected_Conutry_Name
                self?.interActor.getCities(Countries_IDs: [(organizations[indexes[0]].id)!], complition: { (success, error, response) in
                    if success{
                        self?.cities1 = response!
                    }
                        
                    else{
                    }
                })
            case "cities":
                self?.seleted_City_ID = organizations[indexes[0]].id!
                self?.selected_City_Name = organizations[indexes[0]].name!
                self?.cityTEX.text = self?.selected_City_Name
            default:
                print("no case seleted")
                
                
            }
            
        }
        
    }
    
}
