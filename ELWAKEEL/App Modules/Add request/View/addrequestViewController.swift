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
        
       HomeLBL.text = Localization.addRequest
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
        sendBTN.setTitle(Localization.send, for: .normal)
        textView.delegate = self
        
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
        cityBTN.addTarget(self, action: #selector(self.getRegions), for: .touchUpInside)
        
        cityTEX.leftView = cityBTN
        cityTEX.leftViewMode = .always
    }
    func showrAddress(){
        
        addressBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        addressBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        addressBTN.frame = CGRect(x: CGFloat(addressTEX.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        addressBTN.addTarget(self, action: #selector(self.getRegions), for: .touchUpInside)
        
        addressTEX.leftView = addressBTN
        addressTEX.leftViewMode = .always
    }
    func showminstry(){
        minstryBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        minstryBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        minstryBTN.frame = CGRect(x: CGFloat(minstryTxt.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        minstryBTN.addTarget(self, action: #selector(self.getRegions), for: .touchUpInside)
        
        minstryTxt.leftView = minstryBTN
        minstryTxt.leftViewMode = .always
        
    }
    func showachieve(){
        achieveBTN.setImage(UIImage(named: "downArrow"), for: .normal)
        achieveBTN.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        achieveBTN.frame = CGRect(x: CGFloat(achieveTXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        achieveBTN.addTarget(self, action: #selector(self.getRegions), for: .touchUpInside)
        
        achieveTXT.leftView = achieveBTN
        achieveTXT.leftViewMode = .always
        
    }
    
   @objc func getRegions()
    {
        print("hamaad")
    }
    
    @IBAction func backBTN(_ sender: Any) {

//        print("ssssss\(selectedOrgId)")
        dismiss()

    }
    
    @IBAction func sendBTN(_ sender: Any) {
     
        validateData()
        let des = textView.text!
        let address = addressTEX.text!
        if des != nil{
            print("des not nil")
        }
        self.interactor?.addreuest(title: "ssss", description: des, country_id: self.selected_Country_ID, city_id: self.seleted_City_ID, organization_id: selected_Org_Id, address: address, achievement_proof: self.selectedEmail)

        
    }
    func getOrganization(){
      self.interactor?.getorganzation()
        
        
    }
    func getCountries()
    {
       self.interactor?.getCountries()
    }
   
    
        func validateData(){
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
    }
    
}

extension addrequestViewController: IaddrequestViewController {
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

extension addrequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addRequestCell", for: indexPath) as! addRequestCell
        
        cell.title.text = "hamadsa"
         return cell
    }
    
    
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

            if let cities = cities1{
                self.getOrganization1(organizations: cities, view: self)
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
                self?.minstryTxt.text = self?.selected_organization_Name
                
                
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
                self?.cityTEX.text = self?.selected_City_Name
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
