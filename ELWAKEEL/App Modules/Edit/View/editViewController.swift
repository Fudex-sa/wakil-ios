//
//  editViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
import RSSelectionMenu

protocol IeditViewController: class {
	var router: IeditRouter? { get set }
    func assignorganization(organizations: [addrequestModel.Organization])
    func assignCountries(countries: [addrequestModel.Organization])
    func assignCities(cities: [addrequestModel.Organization])
    func assign_reqesut(request: editModel.edit?)

    func backToHome()
}

class editViewController: UIViewController {
	var interactor: IeditInteractor?
	var router: IeditRouter?

    @IBOutlet weak var editDEs: UILabel!
    @IBOutlet weak var serviceDES: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textDes: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var regionTXT: UITextField!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityTXT: UITextField!
    @IBOutlet weak var addressDES: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressTXT: UITextField!
    @IBOutlet weak var minstryTXT: UITextField!
    @IBOutlet weak var minstry: UILabel!
    @IBOutlet weak var minstryDES: UILabel!
    @IBOutlet weak var achieve: UILabel!
    @IBOutlet weak var achieveTXT: UITextField!
    @IBOutlet weak var OK: UIButton!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var titleTXT: UITextField!
    
    
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
    var id = 0
    var request_DES = ""
    var request_address = ""
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        setUpView()
        self.hideKeyboardWhenTappedAround()
        getOrganization()
        addTapGuester()
        getCountries()
        request_details(id: id)
        
    }
    
    func addTapGuester()
    {
        regionTXT.delegate = self
        cityTXT.delegate = self
        minstryTXT.delegate = self
        addressTXT.delegate = self
        achieveTXT.delegate = self
        
    }
    
    func setUpView()
    {
        
        
        editDEs.text = Localization.edit_DES
        addressDES.text = Localization.RequestDes
        city.text = Localization.chooseCit + "*"
        address.text = Localization.authority + "*"
        addressDES.text = Localization.neighborhood
        minstry.text = Localization.ministry + "*"
        minstryDES.text = Localization.agency
        achieve.text = Localization.achievement + "*"
        titleLBL.text = Localization.title_of_service
        OK.setTitle(Localization.ok, for: .normal)
        textView.delegate = self
        self.navigationItem.title = Localization.edit
        
    }
    func getOrganization(){
        self.interactor?.getorganzation()
        
        
    }
    func getCountries()
    {
        self.interactor?.getCountries()
    }
    func validateData(){
        
        guard let title = titleTXT.text, !title.isEmpty else{
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
        guard let city = cityTXT.text, !city.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_City, sender: self)
            cityTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        guard let address = addressTXT.text, !address.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_authority, sender: self)
            addressTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        guard let minstray = minstryTXT.text, !minstray.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_minstry, sender: self)
            minstryTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        guard let provement = achieveTXT.text, !provement.isEmpty else{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.enter_provement, sender: self)
            achieveTXT.attributedPlaceholder =  NSAttributedString(string:Localization.requirdField, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 14)!])
            
            return
        }
        
        request_DES = textView.text!
        request_address = addressTXT.text!
         self.interactor?.edit_request(id: self.id, title: title, description: request_DES, country_id: self.selected_Country_ID , city_id: self.seleted_City_ID , organization_id: selected_Org_Id, address: request_address, achievement_proof: self.selectedEmail)
        
    }
    func request_details(id: Int)
    {
      
            interactor?.getRequest_Datails(id: id)
        
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        dismiss()
    }
    
    
    @IBAction func OK(_ sender: Any) {
        
        validateData()
        
    }
    func configureUI()
    {
        titleTXT.text = edit_request?.title
        textView.text = edit_request?.description
        addressTXT.text = edit_request?.address
        regionTXT.text = edit_request?.country.name
        cityTXT.text = edit_request?.city.name
        minstryTXT.text = edit_request?.organization.name
        achieveTXT.text = edit_request?.achievement_proof
    }
    
}

extension editViewController: IeditViewController {
    func assign_reqesut(request: editModel.edit?) {
        if let request = request{
            self.edit_request = request
            selected_Country_ID = request.country.id!
            seleted_City_ID = request.city.id!
            selected_Org_Id = request.organization.id!
            selectedEmail = request.achievement_proof!
            request_DES = request.description!
            request_address = request.address!
            configureUI()
        }
      
        
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

extension editViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        if textField == regionTXT{
            
            self.type = "countries"
            if let cities = countries{
                self.getOrganization1(organizations: cities, view: self)
                
            }
            return false
        }
        else if textField == cityTXT{
            self.type = "cities"
            
            if let cities = cities1{
                self.getOrganization1(organizations: cities, view: self)
            }
            return false
        }
        else if textField == minstryTXT{
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
	// do someting...
}
extension editViewController: UITextViewDelegate {
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
        
        menu.show(style: .alert(title: "ddddd", action: "ok", height: 300.0), from: view)
        print("hamada")
        
        // on dismiss handler
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
                self?.minstryTXT.text = self?.selected_organization_Name
                
                
            case "countries":
                self?.selected_Country_ID = organizations[indexes[0]].id!
                self?.selected_Conutry_Name = organizations[indexes[0]].name!
                self?.regionTXT.text = self?.selected_Conutry_Name
                self?.interActor.getCities(Countries_IDs: [(organizations[indexes[0]].id)!], complition: { (success, error, response) in
                    if success{
                        print("Getting succeedd")
                        self?.cities1 = response!
                    }
                        
                    else{
                    }
                })
            case "cities":
                self?.seleted_City_ID = organizations[indexes[0]].id!
                self?.selected_City_Name = organizations[indexes[0]].name!
                self?.cityTXT.text = self?.selected_City_Name
            default:
                print("no case seleted")
                
                
            }
            
        }
        
        
        
    }
    
    
    
    func getProveEmails()
    {
        //        provementsEmails.removeAll()
        
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: provementsEmails) { (cell, name, indexpath) in
            cell.textLabel?.text = name
        }
        menu.setSelectedItems(items: selectedEmails) {[weak self] (item, index, isselected, selectedItem) in
            self?.selectedEmails = selectedItem
        }
        menu.cellSelectionStyle = .checkbox
        
        menu.show(style: .alert(title: "ddddd", action: "ok", height: 300.0), from: self)
        menu.onDismiss = { [weak self] items in
            self?.selectedEmail = (self?.selectedEmails[0])!
            self?.achieveTXT.text = (self?.selectedEmails[0])!
            
            
        }
    }
}

extension editViewController {
	// do someting...
}
