//
//  ChatViewController.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/2/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework
protocol IChatViewController: class {
	var router: IChatRouter? { get set }
    func assing_messages(message: ChatModel.data)
    func get_messages()
    func admin_join()
}

class ChatViewController: UIViewController {
	var interactor: IChatInteractor?
	var router: IChatRouter?

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var chatTable_view: UITableView!
    @IBOutlet weak var upload_view: UIView!
    @IBOutlet weak var upload_tableView: UITableView!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var frameView: UIView!
    var img_array: [String] = ["upload","file","call_manger","complaint"]
    var table_title: [String] = [Localization.upload_file, Localization.upload_image, Localization.call_manger, Localization.compliant]
    var messegae: ChatModel.data?
    var sender_id = UserDefaults.standard.integer(forKey: "id")
    var reciver_id: Int?
    var service_id: Int?
    var file_url: URL?
    var picker = UIImagePickerController()
    var image_url: URL?
    var params: [String:Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
        
        set_up_view()
        get_messages()
       
        hideKeyboardWhenTappedAround()
        keyboard_observer()
        
    }
  
    func set_up_view()
    {  img.isHidden = true
        message.delegate = self
        picker.delegate = self
        picker.mediaTypes = ["public.image", "public.movie"]
        upload_view.isHidden = true
        upload_tableView.delegate = self
        upload_tableView.dataSource = self
        chatTable_view.delegate = self
        chatTable_view.dataSource = self
        container.layer.cornerRadius = 7
        let upload_nib = UINib(nibName: "upload", bundle: nil)
        upload_tableView.register(upload_nib, forCellReuseIdentifier: "upload")
        let nib = UINib(nibName: "chat_cell", bundle: nil)
        chatTable_view.register(nib, forCellReuseIdentifier: "chat_cell")
        
    }
    func extract_data()
    {
        if let params = params{
        if UserDefaults.standard.string(forKey: "type") == "provider"{
            self.reciver_id = params["client_id"] as? Int
            self.sender_id = params["service_id"] as! Int
        }
        else{
            self.reciver_id = params["provider_id"] as? Int
            self.sender_id = params["service_id"] as! Int
            
        }
        }
    }
    func keyboard_observer()
      {
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      @objc func keyboardWillShow(notification: NSNotification) {
              
          guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
             // if keyboard size is not available for some reason, dont do anything
             return
          }
        
        self.view.frame.origin.y = 0 - keyboardSize.height
      }

      @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
      }
    func reload_tableView ()
    {
        self.chatTable_view.reloadData() // To populate your tableview first
        //Since we have to wait until the table is reload
         DispatchQueue.main.async {
         let bottomOffset = CGPoint(x: 0, y: self.chatTable_view.contentSize.height - self.chatTable_view.frame.size.height)
         self.chatTable_view.setContentOffset(bottomOffset, animated: false)
         }
    }
    
    @IBAction func upload(_ sender: Any) {

        if upload_view.isHidden == true{

                self.upload_view.isHidden = false


        }
        else if upload_view.isHidden == false{
            upload_view.isHidden = true
        }
    }
    @IBAction func send(_ sender: Any) {
        guard let text = message.text, !text.isEmpty else{
            return
        }
        if let service_id = service_id, let reciver_id = reciver_id {
            
            let para: [String: Any] = ["service_id": service_id, "sender_id": sender_id, "receiver_id": reciver_id, "type": "text"]
                   interactor?.create_message(params: para, message: text)
        }
        
       

               message.text = nil
        
    }
    func pick_image(){
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
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
             picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
        }
    }
    func make_complaint()
    {
        
        let alert = UIAlertController(title: Localization.report_complaint, message: Localization.report_complaint_des, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: Localization.send, style: .default) { (action) in
             let reason = (alert.textFields?[0].text)!
            
            self.interactor?.make_compliant(service_id: 50, added_by: self.sender_id, user_id: 4, content: reason)
            
        }
        
        let cancelAction = UIAlertAction(title: Localization.cancel, style: .default) { (action) in
        }
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(sendAction)
        present(alert,animated: true,completion: nil)
        
        
    }
    
    func get_file()
    
    {
       let importMenu = UIDocumentPickerViewController(documentTypes: ["public.text"], in: .import)
        importMenu.delegate = self
        self.present(importMenu, animated: true, completion: nil)
    }
    
}

extension ChatViewController: IChatViewController {
    func admin_join() {
        let alert = UIAlertController(title:"", message: Localization.admin_join, preferredStyle: .alert)
               
               
        let cancelAction = UIAlertAction(title: Localization.ok, style: .default) { (action) in
               }
               alert.addAction(cancelAction)
               present(alert,animated: true,completion: nil)
    }
    
    func get_messages() {
        interactor?.get_messages(service_id: 50)

    }
    func call_manger()
    {
        interactor?.call_manger(service_id: 50)
    }
    
    func assing_messages(message: ChatModel.data) {
     
            self.messegae = message
            chatTable_view.reloadData()
        let last_index = (messegae?.messages.endIndex)! - 1
            print("last\(last_index)")
        let lastIndex = NSIndexPath(row: last_index , section: 0)
            
            chatTable_view.scrollToRow(at: lastIndex as IndexPath, at: .bottom, animated: true)

        
 
    }
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == upload_tableView
        {
            return 4
        }
        else if tableView == chatTable_view {
            return messegae?.messages.count ?? 0
        }
        
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == upload_tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "upload", for: indexPath) as! upload
            cell.img.image = UIImage(named: img_array[indexPath.row])
            cell.title.text = table_title[indexPath.row]
            cell.selectionStyle = .none
            
             return cell
            
        }
        else if tableView == chatTable_view{
            let cell = tableView.dequeueReusableCell(withIdentifier: "chat_cell", for: indexPath) as! chat_cell
            cell.stack_direction(type: .incoming)
            cell.user_name.text = messegae?.messages[indexPath.row].sender.name
            if messegae?.messages[indexPath.row].type == "text" {
                cell.message_text.text = messegae?.messages[indexPath.row].message

            }
            else {
                var data = "http://wakil.dev.fudexsb.com"
                if let file_data = messegae?.messages[indexPath.row].message{
                   data.append(contentsOf: file_data)
                    cell.message_text.text = data
                }
               
            }
            if sender_id == messegae?.messages[indexPath.row].sender.id{
                cell.stack_direction(type: .incoming)
            }
            else {
                cell.stack_direction(type: .outgoing)

            }
            
             return cell
        }
        
        else{
            return UITableViewCell.init()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == upload_tableView{
            switch indexPath.row{
            case 0:
                print("4")
             pick_image()
            case 1:
                print("2")
                get_file()

            case 2:
                print("3")
                call_manger()

            case 3:
                make_complaint()

            default:
                print("no case selected")
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        upload_view.isHidden = true
    }
}
extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
           return false    }
    func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
           tap.cancelsTouchesInView = false
           chatTable_view.addGestureRecognizer(tap)
       }
       
       @objc func dismissKeyboard() {
      view.endEditing(true)
           // do someting...
       }
       

}
extension ChatViewController: UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("url \(urls[0])")
        self.file_url = urls[0]
        if let file_url = self.file_url {
            if let service_id = service_id, let reciver_id = reciver_id {
                let para: [String: Any] = ["service_id": service_id, "sender_id": sender_id, "receiver_id": reciver_id, "type": "file"]
                interactor?.create_message(params: para, message: file_url)
            }
    
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType  == "public.image" {
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    if let service_id = service_id, let reciver_id = reciver_id {
                        let para: [String: Any] = ["service_id": service_id, "sender_id": sender_id, "receiver_id": reciver_id, "type": "img"]
                        interactor?.create_message(params: para, message: image)
                        img.image = image
                    }
                    
                }
                
                img.isHidden = false
                dismiss(animated: true, completion: nil)
            }
            
            if mediaType == "public.movie" {
                if let url  = info[UIImagePickerController.InfoKey.mediaURL] as? URL
                {
                     if let service_id = service_id, let reciver_id = reciver_id {
                        let para: [String: Any] = ["service_id": service_id, "sender_id": sender_id, "receiver_id": reciver_id, "type": "video"]
                        interactor?.create_message(params: para, message: url)
                    }
                    
                    
                    dismiss(animated: true, completion: nil)

                }

                print("Video Selected")
            }
        }
        
    }

}
