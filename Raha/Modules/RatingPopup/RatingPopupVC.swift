//
//  RatingPopupVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
protocol RatingPopupVCDelegate: AnyObject {
    func done()
}
// MARK: - ...  ViewController - Vars
class RatingPopupVC: BaseController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var coomentTxt: UITextView!
    @IBOutlet weak var rateView: CosmosView!
    var viewModel: RatingPopupViewModel?
    var coordinator: RatingPopupCoordinator?
    var delegate: RatingPopupVCDelegate?
    var orderId = 0
}

// MARK: - ...  LifeCycle
extension RatingPopupVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        coomentTxt.text =  "Write your comment".localized
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.didError(error: error?.localizedDescription)
        })
        viewModel?.ratedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle(self?.viewModel?.ratedata.value?.message ?? "")
                .setBody("")
                .setTheme(.success)
                .bulid()
            self?.delegate?.done()
            self?.dismiss(animated: true, completion: nil)
        })
        
    }
    
}
// MARK: - ...  Functions
extension RatingPopupVC {
    func setup() {
        viewModel?.orderId.send(orderId ?? 0)
        coomentTxt.delegate = self
        coomentTxt.textColor = R.color.black3()
        sendBtn.publisher.listen(on: {[weak self] _ in
            var error = ""
            if self?.coomentTxt.text == self?.coomentTxt.localization || self?.coomentTxt.text == "" {
                error = "Write your comment".localized
            }
            if self?.rateView.rating.int ?? 0 == 0 {
                error = "\(error) \n \("make rating".localized)"
            }
           
            if error == "" {
                self?.viewModel?.comment.send(self?.coomentTxt.text ?? "")
                self?.viewModel?.rate.send(self?.rateView.rating.int.string ?? "0")
                self?.startLoading()
                self?.viewModel?.fetchrate()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
        closeBtn.publisher.listen(on: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).store(self)
    }
}
// MARK: - ...  View Contract
extension RatingPopupVC {
}
extension RatingPopupVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if coomentTxt.textColor == R.color.black3() {
                coomentTxt.text = nil
                coomentTxt.textColor = R.color.black1()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if coomentTxt.text.isEmpty {
                coomentTxt.textColor = R.color.black3() // YOUR PREFERED PLACEHOLDER COLOR HERE
                coomentTxt.text =  "Write your comment".localized
            }
        }
           
}
