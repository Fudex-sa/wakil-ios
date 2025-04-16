//
//  SendcomplainVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SendcomplainVC: BaseController {
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextView!
    var viewModel: SendcomplainViewModel?
    var coordinator: SendcomplainCoordinator?
    var complains: [RegisterModel] = []

}

// MARK: - ...  LifeCycle
extension SendcomplainVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTxt.text =  "Message text".localized
        complains.removeAll()
        complains.append(RegisterModel.init(id: 1, name: "Complaint".localized))
        complains.append(RegisterModel.init(id: 2, name: "Suggestion".localized))

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.contact.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle(self?.viewModel?.contact.value?.message ?? "")
                .setBody("Thank you for contacting us, we will preview the message and reply to you as soon as possible".localized)
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
        })
       
    }
}
// MARK: - ...  Functions
extension SendcomplainVC {
    func setup() {
        messageTxt.delegate = self
        messageTxt.textColor = R.color.black3()
        sendBtn.publisher.listen(on: {[weak self] _ in
            var error = ""
            if self?.messageTxt.text == self?.messageTxt.localization || self?.messageTxt.text == "" {
                error = "\(error) \("write message".localized)\n"

            }
            if self?.viewModel?.type.value ?? "" == "" {
                error = "\(error) \("select message type".localized)\n"
            }
           
            if error == "" {
                self?.viewModel?.message.send(self?.messageTxt.text ?? "")
                self?.startLoading()
                self?.viewModel?.sendMessage()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
        typeView.publisherGesture.listen(on: {[weak self] _ in
            self?.picktypes()
        }).store(self)
    }
    func picktypes() {
        let scene = SearchViewPicker(nib: R.nib.searchViewPicker)
        scene.pickTitle.send("Message Type".localized)
        scene.source = complains
        scene.didSelectItem.listen(on: { [weak self] didSelect in
            guard let item = didSelect?.1 as? RegisterModel else { return }
            self?.typeLbl.text = item.name ?? ""
            self?.typeLbl.textColor = R.color.black()
            if item.id ?? 0 == 1 {
                self?.viewModel?.type.send("complaint")
            }else if item.id ?? 0 == 2 {
                self?.viewModel?.type.send("suggesstion")
            }
        })
        self.pushPop(scene)
    }
}
// MARK: - ...  View Contract
extension SendcomplainVC {
}
extension SendcomplainVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if messageTxt.textColor == R.color.black3() {
                messageTxt.text = nil
                messageTxt.textColor = R.color.black1()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if messageTxt.text.isEmpty {
                messageTxt.textColor = R.color.black3() // YOUR PREFERED PLACEHOLDER COLOR HERE
                messageTxt.text =  "Message text".localized
            }
        }
           
}
