//
//  VerifyCodeInputs.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit


protocol VerifyCodeInputsDataSource: NSObjectProtocol {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, view: Bool?) -> UIView?
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, txfs: Bool?) -> [UITextField]
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, textBorder: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBackground: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillBackground: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyTextColor: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillTextColor: Bool?) -> UIColor
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, keyboardType: Bool?) -> UIKeyboardType
}
extension VerifyCodeInputsDataSource {
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBorder: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, textBorder: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, completeBorder: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyBackground: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillBackground: Bool?) -> UIColor {
        return .clear
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, emptyTextColor: Bool?) -> UIColor {
        return .black
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, fillTextColor: Bool?) -> UIColor {
        return .black
    }
    func verifyCodeInputs(_ inputs: VerifyCodeInputs?, keyboardType: Bool?) -> UIKeyboardType {
        return .asciiCapableNumberPad
    }
}
class VerifyCodeInputs: NSObject {
    weak var dataSource: VerifyCodeInputsDataSource? {
        didSet {
            setup()
            resetBorderColors()
        }
    }
//    var code1Txf: UITextField? {
//        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 0]
//    }
//    var code2Txf: UITextField? {
//        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 1]
//    }
//    var code3Txf: UITextField? {
//        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 2]
//    }
//    var code4Txf: UITextField? {
//        return dataSource?.verifyCodeInputs(self, txfs: true)[safe: 3]
//    }
    var textFields: [UITextField] {
        return dataSource?.verifyCodeInputs(self, txfs: true) ?? []
    }
    var firstTextField: UITextField? {
        return textFields[safe: 0]
    }
    var lastTextField: UITextField? {
        return textFields.last
    }
    var view: UIView? {
        return dataSource?.verifyCodeInputs(self, view: true)
    }
    var code: String? {
        var string = ""
        if Localizer.current == .arabic {
            for textField in textFields.reversed() {
                string += "\(textField.text ?? "")"
            }
            //string = "\(code4Txf?.text ?? "")\(code3Txf?.text ?? "")\(code2Txf?.text ?? "")\(code1Txf?.text ?? "")"
        } else {
            for textField in textFields {
                string += "\(textField.text ?? "")"
            }
            //string = "\(code1Txf?.text ?? "")\(code2Txf?.text ?? "")\(code3Txf?.text ?? "")\(code4Txf?.text ?? "")"
        }
        if string.count == (dataSource?.verifyCodeInputs(self, txfs: true).count ?? 0) {
            return string
        } else {
            return nil
        }
    }
    func setup() {
        textFields.forEach { textField in
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField.keyboardType = self.dataSource?.verifyCodeInputs(self, keyboardType: true) ?? .asciiCapableNumberPad
            textField.textAlignment = .center
        }
//        code1Txf?.delegate = self
//        code2Txf?.delegate = self
//        code3Txf?.delegate = self
//        code4Txf?.delegate = self
//        code1Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        code2Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        code3Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        code4Txf?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//        code1Txf?.keyboardType = .asciiCapableNumberPad
//        code2Txf?.keyboardType = .asciiCapableNumberPad
//        code3Txf?.keyboardType = .asciiCapableNumberPad
//        code4Txf?.keyboardType = .asciiCapableNumberPad
//
//        code1Txf?.textAlignment = .center
//        code2Txf?.textAlignment = .center
//        code3Txf?.textAlignment = .center
//        code4Txf?.textAlignment = .center
    }
    func resetBorderColors() {
        textFields.forEach { textField in
            textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
        }
//        code1Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
//        code2Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
//        code3Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
//        code4Txf?.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
    }
    
    func reset() {
        textFields.forEach { textField in
            textField.text = "-"
        }
//        code1Txf?.text = "-"
//        code2Txf?.text = "-"
//        code3Txf?.text = "-"
//        code4Txf?.text = "-"
    }
    func nextTextField(_ index: Int) -> UITextField? {
        return textFields[safe: index]
    }
}
 

// MARK:  Text fielde delegate
extension VerifyCodeInputs: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, textBorder: true)
        textField.superview?.backgroundColor = dataSource?.verifyCodeInputs(self, emptyBackground: true)
        textField.textColor = dataSource?.verifyCodeInputs(self, emptyTextColor: true)
        if let text = textField.text {
            if text.count > 0 {
                textField.text = ""
            }
        }
//        switch textField {
//            case firstTextField:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        firstTextField?.text = ""
//                    }
//                }
//            case nextTextField(1):
//                if let text = textField.text {
//                    if text.count > 0 {
//                        nextTextField(1)?.text = ""
//                    }
//                }
//            case nextTextField(2):
//                if let text = textField.text {
//                    if text.count > 0 {
//                        nextTextField(2)?.text = ""
//                    }
//                }
//            case nextTextField(3):
//                if let text = textField.text {
//                    if text.count > 0 {
//                        nextTextField(3)?.text = ""
//                    }
//                }
//            default:
//                break
//        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count > 0 && text != "-" {
                textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, completeBorder: true)
                textField.superview?.backgroundColor = dataSource?.verifyCodeInputs(self, fillBackground: true)
                textField.textColor = dataSource?.verifyCodeInputs(self, fillTextColor: true)
            } else {
                textField.text = "-"
                textField.superview?.borderColor = dataSource?.verifyCodeInputs(self, emptyBorder: true)
                textField.superview?.backgroundColor = dataSource?.verifyCodeInputs(self, emptyBackground: true)
                textField.textColor = dataSource?.verifyCodeInputs(self, emptyTextColor: true)
            }
        }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length > 1 {
            return false
        } else {
            return true
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if Localizer.current == .arabic {
            setupArabic(textField)
            return
        }
        for index in 0..<textFields.count {
            if textField == textFields[index] {
                if index+1 == textFields.count {
                    if let text = textField.text {
                        if text.count > 0 {
                            textField.endEditing(true)
                        } else {
                            nextTextField(index-1)?.becomeFirstResponder()
                        }
                    }
                } else {
                    if let text = textField.text {
                        if text.count > 0 {
                            nextTextField(index+1)?.becomeFirstResponder()
                        } else {
                            view?.endEditing(true)
                        }
                    }
                }
               
            }
        }
        
            
//        switch textField {
//            case code1Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code2Txf?.becomeFirstResponder()
//                    } else {
//                        view?.endEditing(true)
//                    }
//                }
//            case code2Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code3Txf?.becomeFirstResponder()
//                    } else {
//                        code1Txf?.becomeFirstResponder()
//                    }
//                }
//            case code3Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code4Txf?.becomeFirstResponder()
//                    } else {
//                        code2Txf?.becomeFirstResponder()
//                    }
//                }
//            case code4Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        textField.endEditing(true)
//                    } else {
//                        code3Txf?.becomeFirstResponder()
//                    }
//                }
//            default:
//                break
//        }
    }
    func setupArabic(_ textField: UITextField) {
        var counter = textFields.count - 1
        for index in 0..<textFields.count {
            if textField == textFields[counter] {
                if index + 1 == textFields.count {
                    if let text = textField.text {
                        if text.count > 0 {
                            view?.endEditing(true)
                        } else {
                            nextTextField(counter+1)?.becomeFirstResponder()
                        }
                    }
                } else {
                    if let text = textField.text {
                        if text.count > 0 {
                            nextTextField(counter-1)?.becomeFirstResponder()
                        } else {
                            view?.endEditing(true)
                        }
                    }
                }
            }
            counter -= 1
        }
//        switch textField {
//
//            case code4Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code3Txf?.becomeFirstResponder()
//                    } else {
//                        view?.endEditing(true)
//                    }
//                }
//            case code3Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code2Txf?.becomeFirstResponder()
//                    } else {
//                        code4Txf?.becomeFirstResponder()
//                    }
//                }
//            case code2Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        code1Txf?.becomeFirstResponder()
//                    } else {
//                        code3Txf?.becomeFirstResponder()
//                    }
//                }
//            case code1Txf:
//                if let text = textField.text {
//                    if text.count > 0 {
//                        view?.endEditing(true)
//                    } else {
//                        code2Txf?.becomeFirstResponder()
//                    }
//                }
//            default:
//                break
//        }
    }
}
