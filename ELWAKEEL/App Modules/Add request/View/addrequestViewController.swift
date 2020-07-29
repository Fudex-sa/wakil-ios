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
    var selected: [addrequestModel.Organization] = [addrequestModel.Organization]()
    var organizations: [addrequestModel.Organization]?
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
        
    }
    
    
    @IBAction func hide(_ sender: Any) {
        
//        container.isHidden = true
    }
    
    
    func addTapGuester()
    {
      regionTXT.delegate = self
        cityTEX.delegate = self
        minstryTxt.delegate = self
        addressTEX.delegate = self
        achieveTXT.delegate = self
    }
    
    func showRegios()
    {
        let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource: organizations!) { (cell, name, indexpath) in
            cell.textLabel?.text = name.name
        }
        print("selected1\(selected)")
        menu.setSelectedItems(items: selected) {[weak self] (item, index, isselected, selectedItem) in
            self?.selected = selectedItem
             print("selected\(self?.selected)")
        }
        menu.cellSelectionStyle = .checkbox
        menu.show(style: .alert(title: "hamada", action: "hamafa", height: Double( self.view.frame.size.height * 0.50)), from: self)
        // on dismiss handler
        menu.onDismiss = { [weak self] items in
            print("selected\(self?.selected)")
            self?.selected = items
            for item in items{
                print(item)
            }
            
        }
       
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
//         dismiss()
//        container.isHidden = false
        print("wwwww\(organizations)")
        
    }
    
    @IBAction func sendBTN(_ sender: Any) {
     
        validateData()
        let des = textView.text!
        let region = regionTXT.text!
        let city = cityTEX.text!
        let address = addressTEX.text!
        let minstray = minstryTxt.text!
        let provement = achieveTXT.text!
        self.interactor?.addreuest(title: "ssss", description: des, country_id: 1, city_id: 3, organization_id: 2, address: "minia", achievement_proof: "email")
//
        dismiss()
        
    }
    func getOrganization(){
      self.interactor?.getorganzation()
        
        
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
    
    
	// do someting...
}


extension addrequestViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        showRegios()
        for item in selected{
            print("items \(item.name)")
        }
        
        return false
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
    
}
