//
//  Validator.swift
//  FormValidator
//
//  Created by Islam  on 6/2/21.
//

import Foundation
import UIKit


// MARK: - ...  Validator class
open class Validator: NSObject {
    // MARK: - ...  vars
    private var textFields: [GuardModel] = []
    private var guardOnSuperViewOfTextField: Bool = false
    private var validatorUIType: [ValidatorUIType] = [.none]
    weak var delegate: ValidatorTextFieldDelegate?
    
    // MARK: - ...  init
    override init() { }

    init(guardOnSuperViewOfTextField: Bool = false) {
        self.guardOnSuperViewOfTextField = guardOnSuperViewOfTextField
    }
    @discardableResult
    func setUIType(_ type: ValidatorUIType) -> Self {
        self.validatorUIType.append(type)
        return self
    }
    func build() -> Bool {
        return validate
    }
}

// MARK: - ...  append
extension Validator {
    @discardableResult
    func append(_ textField: UITextField, rules: [Guard], title: String?) -> GuardModel {
        textField.delegate = self
        textField.addTarget(self, action: #selector(Validator.textFieldDidChange(_:)), for: .editingChanged)
        
        let model = GuardModel(textField: textField).rules(rules).setTitle(title)
        textFields.append(model)
        return model
    }
    func trash() {
        textFields.forEach { model in
            model.textField.delegate = nil
        }
        textFields.removeAll()
    }
}
// MARK: - ...  validate
extension Validator {
    private var validate: Bool {
        var successValidate = true
        for textField in textFields {
            if !validateGuard(textField) {
                successValidate = false
                break
            }
        }
        return successValidate
    }
}


// MARK: - ...  Validator guard
extension Validator: ValidatorGuard {
    func validateGuard(_ textField: UITextField) -> Bool? {
        for field in textFields {
            if field.textField == textField {
                return validateGuard(field)
            }
        }
        return nil
    }
    func validateGuard(_ textField: GuardModel) -> Bool {
        var successValidate = true
        for var rule in textField.rules {
            rule.textField = textField.textField
            if !rule.confirm() {
                successValidate = false
                textField.shake(guardOnSuperViewOfTextField)
                handleTextFieldError(textField.textField)
                handleSuperViewOfTextField(textField.textField, false)
            } else {
                handleTextFieldSuccess(textField.textField)
                handleSuperViewOfTextField(textField.textField, true)
            }
        }
        return successValidate
    }
    func guardModel(_ textField: UITextField) -> GuardModel? {
        for index in 0..<textFields.count {
            if textFields[index].textField == textField {
                return textFields[index]
            }
        }
        return nil
    }
}

// MARK: - ...  Handle UI
extension Validator: ValidatorUI, ValidatorUnderlineUI, ValidatorInfoMarkUI, ValidatorLabelUI {
    func handleTextFieldError(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            textField.textColor = .red
        } else {
            textField.setPlaceHolderTextColor(.red)
        }
    }
    func handleTextFieldSuccess(_ textField: UITextField) {
        let model = guardModel(textField)
        if textField.text?.isEmpty == false {
            textField.textColor = model?.oldTextColor ?? .black
        } else {
            textField.setPlaceHolderTextColor(model?.oldPlaceHolderColor ?? .placeholderText)
        }
    }
    func handleSuperViewOfTextField(_ textField: UITextField, _ success: Bool) {
        for ui in validatorUIType {
            switch ui {
            case .infoMark:
                handleInfoMark(textField, success)
            case .underline:
                handleUnderline(textField, success)
            case .label:
                handleLabel(textField, success)
            case .message:
                handleMessage(textField, success)
            case .scroll(let scroll):
                handleScroll(scroll, for: textField)
            default:
                break
            }
        }
    }
    
    func handleUnderline(_ textField: UITextField, _ success: Bool) {
        if !guardOnSuperViewOfTextField {
            return
        }
        let model = guardModel(textField)
        if success {
            removeUnderline(in: model)
        } else {
            insertUnderline(in: model)
        }
    }
    func handleInfoMark(_ textField: UITextField, _ success: Bool) {
        if !guardOnSuperViewOfTextField {
            return
        }
        let model = guardModel(textField)
        if success {
            removeInfoMark(in: model)
        } else {
            insertInfoMark(in: model)
        }
    }
    func handleLabel(_ textField: UITextField, _ success: Bool) {
        if !guardOnSuperViewOfTextField {
            return
        }
        let model = guardModel(textField)
        if success {
            removeLabel(in: model)
        } else {
            insertLabel(in: model)
        }
    }
    func handleScroll(_ scrollView: UIScrollView, for textField: UITextField) {
        let point = CGPoint(x: scrollView.x, y: textField.y)
        scrollView.setContentOffset(point, animated: true)
    }
    func handleMessage(_ textField: UITextField, _ success: Bool) {
        let model = guardModel(textField)
        if !success {
            NotificationBuilder().setBody(model?.errorMessage()).bulid()
        }
    }
}


// MARK: - ...  TextField Delegation
extension Validator: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        handleTextFieldSuccess(textField)
        if guardOnSuperViewOfTextField {
            handleSuperViewOfTextField(textField, true)
        }
        delegate?.textFieldDidBeginEditing?(textField)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if validateGuard(textField) == true {
            handleTextFieldSuccess(textField)
            if guardOnSuperViewOfTextField {
                handleSuperViewOfTextField(textField, true)
            }
        } else {
            handleTextFieldError(textField)
            if guardOnSuperViewOfTextField {
                handleSuperViewOfTextField(textField, false)
            }
        }
        delegate?.textFieldDidEndEditing?(textField)
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        // MARK: - ...  Check is max char in text field
        let model = guardModel(textField)
        for rule in model?.rules ?? [] {
            if let rule = rule as? GuardLength {
                if let max = rule.max {
                    if newString.length > max {
                        return false
                    } else {
                        return true
                    }
                }
            }
        }
        return true
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        handleTextFieldSuccess(textField)
        if guardOnSuperViewOfTextField {
            handleSuperViewOfTextField(textField, true)
        }
        delegate?.textFieldDidChange?(textField)
    }
}



