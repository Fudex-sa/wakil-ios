//
//  secondScreenViewController.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol IsecondScreenViewController: class {
	var router: IsecondScreenRouter? { get set }
    func assingNewProvider(provider: secondScreenModel.newUser)
    func moveToVerification(type: String)
    func showAlert(title: String, msg: String)
}

class secondScreenViewController: UIViewController {
	var interactor: IsecondScreenInteractor?
	var router: IsecondScreenRouter?

    @IBOutlet weak var newaccount: UILabel!
    @IBOutlet weak var createNewAccountLBL: UILabel!
    @IBOutlet weak var accountDescriptionLBL: UILabel!
    @IBOutlet weak var bankNameLBL: UILabel!
    @IBOutlet weak var numberLBL: UILabel!
    @IBOutlet weak var recordNumberLBL: UILabel!
    @IBOutlet weak var recordImageLBL: UILabel!
    @IBOutlet weak var conditionsLBL: UILabel!
    @IBOutlet weak var recordImage2LBL: UILabel!
    @IBOutlet weak var SendBTN: UIButton!
    @IBOutlet weak var bankNameTXT: UITextField!
    @IBOutlet weak var numberTXT: UITextField!
    @IBOutlet weak var recordNumTXT: UITextField!
    @IBOutlet weak var recordImageTXt: UITextField!
    @IBOutlet weak var recordImage2TXT: UITextField!
    @IBOutlet weak var termsLBL: UILabel!
    @IBOutlet weak var checkBTN: UIButton!
    
 
    var pickerLicence = UIImagePickerController()
    var pickerCommercial = UIImagePickerController()
    var id: Int = 9
    var comerialImage: UIImage?
    var licenceImage: UIImage?
    var unchecked = true
    let preferredLanguage = NSLocale.preferredLanguages[0]
    var provider: secondScreenModel.newUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ID\(id)")
        setUpView()
        setUpcompoents()
        setUpTEXTFEILD()
        addBTN2()
        
    }
    
    func setUpTEXTFEILD()
    {
    
        bankNameTXT.delegate = self
        numberTXT.delegate = self
        recordImage2TXT.delegate = self
        recordImageTXt.delegate = self
        recordNumTXT.delegate = self
        
    }
    func setUpcompoents()
    {
        
        newaccount.text = Localization.newAccount
        createNewAccountLBL.text = Localization.createAccount
        accountDescriptionLBL.text = Localization.accountDescription
        bankNameLBL.text = Localization.bankName + "*"
        numberLBL.text = Localization.IBANNumber + "*"
        recordNumberLBL.text = Localization.commercialRegisterationNumber + "*"
        recordImageLBL.text = Localization.customsclearancelicesnecopy
        conditionsLBL.text = Localization.imagaDes
        termsLBL.text = Localization.conditions
        recordImage2LBL.text = Localization.clearancelicense
        SendBTN.setTitle(Localization.send, for: .normal)
        checkBTN.layer.borderWidth = 1.0
        
        
    }
    
    @IBAction func BackBTN(_ sender: Any) {
        dismiss()
    }
    
    func setUpView()
    {
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "upload"), for: .normal)
        button1.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        button1.frame = CGRect(x: CGFloat(recordImageTXt.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button1.addTarget(self, action: #selector(self.upload), for: .touchUpInside)
        
             recordImageTXt.leftView = button1
            recordImageTXt.leftViewMode = .always
        
        
    }
    func addBTN2(){
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "upload"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 7)
        button2.frame = CGRect(x: CGFloat(recordImage2TXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button2.addTarget(self, action: #selector(self.uploadimage), for: .touchUpInside)

        recordImage2TXT.leftView = button2
        recordImage2TXT.leftViewMode = .always
        
    }
    
    @IBAction func chechBTN(_ sender: UIButton) {
       
        if unchecked {
            sender.setImage(UIImage(named:"check"), for: .normal)
            unchecked = false
        }
        else {
            sender.setImage( UIImage(named:""), for: .normal)
            unchecked = true
        }
    
    }
    
    
    @objc func upload()
    {

        showAlert(picker: pickerCommercial)
    }
    @objc func uploadimage()
    {
        showAlert(picker: pickerLicence)
        
    }
    
    @IBAction func sendBTN(_ sender: Any) {
        
        guard let bankName = bankNameTXT.text,
              let ibanNumber = numberTXT.text,
              let comercialNumber = recordNumTXT.text
        else {
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            
            print("error Gurd")
            return
        }
        let iban = Int(ibanNumber)!
        let comNumber = Int(comercialNumber)
        if comerialImage == nil || licenceImage == nil{
            ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.wrongField, sender: self)
            print("Error If")
            return
    }
        else if unchecked == true{
           
                ShowAlertView.showAlert(title: Localization.errorLBL, msg: Localization.acceptTerms, sender: self)
                return
            }
        
        else{
            
             self.interactor?.register(type: "provider", commercial_number: comNumber!, bank_name: bankName, bank_iban: iban, commercial_image: comerialImage!, license_image: licenceImage!, id: id)
    }
    }
  
    
    private func showAlert(picker: UIImagePickerController) {
        
        let alert = UIAlertController(title: Localization.chooseImageALert, message: Localization.alertMSG, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Localization.camara, style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera, pickerImage: picker)
        }))
        alert.addAction(UIAlertAction(title: Localization.photoAlbum, style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary, pickerImage: picker)
        }))
        alert.addAction(UIAlertAction(title: Localization.cancel, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType, pickerImage: UIImagePickerController) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerImage.delegate = self
            pickerImage.sourceType = sourceType
            self.present(pickerImage, animated: true, completion: nil)
        }
    }
}
extension secondScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == pickerCommercial{
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            comerialImage = image
            self.recordImageTXt.text = "\(comerialImage!)"
            
        }
        else{
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            licenceImage = image
            self.recordImage2TXT.text = "\(licenceImage!)"
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}
extension secondScreenViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        
}
}

extension secondScreenViewController: IsecondScreenViewController {
    func moveToVerification(type: String) {
        router?.MoveToVerification(type: type)
    }
    
   
    
    func showAlert(title: String, msg: String) {
        ShowAlertView.showAlert(title: title, msg: msg, sender: self)
    }
    
    func assingNewProvider(provider: secondScreenModel.newUser) {
        self.provider = provider
    }
    
   
    
	// do someting...
}

extension secondScreenViewController {
    
    
	// do someting...
}

extension secondScreenViewController {
	// do someting...
}
