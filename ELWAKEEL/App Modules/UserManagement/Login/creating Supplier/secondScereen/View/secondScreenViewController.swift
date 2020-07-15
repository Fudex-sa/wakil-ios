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
    
    var checked = false
    var check2 = false
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpcompoents()
        setUpTEXTFEILD()
        addBTN2()
        
    }
    
    func setUpTEXTFEILD()
    {
     bankNameTXT.delegate = self
        numberTXT.delegate = self
        recordNumTXT.delegate = self
        recordImageTXt.delegate = self
        recordImage2TXT.delegate = self
        bankNameTXT.tag = 0
        numberTXT.tag = 1
        recordNumTXT.tag = 2
        recordImageTXt.tag = 3
        recordImage2TXT.tag = 4
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
        button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        button1.frame = CGRect(x: CGFloat(recordImageTXt.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button1.addTarget(self, action: #selector(self.upload), for: .touchUpInside)
        recordImageTXt.leftView = button1
        recordImageTXt.leftViewMode = .always
        
    }
    func addBTN2(){
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "upload"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        button2.frame = CGRect(x: CGFloat(recordImage2TXT.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button2.addTarget(self, action: #selector(self.uploadimage), for: .touchUpInside)
        recordImage2TXT.leftView = button2
        recordImage2TXT.leftViewMode = .always
        
    }
    
    
    @IBAction func chechBTN(_ sender: UIButton) {
        
        if (sender.isSelected == true)
        {
            sender.setBackgroundImage(UIImage(named: "check"), for: UIControl.State.normal)
            sender.isSelected = false;
        }
        else
        {
           
            sender.isSelected = true;
        }
    }
    
    
    @objc func upload()
    {
       self.checked = true
        showAlert()
    }
    @objc func uploadimage()
    {
        self.check2 = true
        showAlert()
        
    }
    
    @IBAction func sendBTN(_ sender: Any) {
        self.navigate(type: .modal, module: GeneralRouterRoute.verification, completion: nil)
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(title: Localization.chooseImageALert, message: Localization.alertMSG, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Localization.camara, style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: Localization.photoAlbum, style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: Localization.cancel, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
}
extension secondScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if checked == true {
            let image = info[.originalImage] as? UIImage
            self.recordImageTXt.text = Localization.uploaded
            self.checked = false
           
            
        }
        if check2 == true{
            let image = info[.originalImage] as? UIImage
            self.recordImage2TXT.text = Localization.uploaded
            self.check2 = false
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}
extension secondScreenViewController: UITextFieldDelegate{
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        let nextTextFieldTag = textField.tag + 1
        
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension secondScreenViewController: IsecondScreenViewController {
	// do someting...
}

extension secondScreenViewController {
	// do someting...
}

extension secondScreenViewController {
	// do someting...
}
