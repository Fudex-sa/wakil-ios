//
//  ServicetypeCollectionViewCell.swift
//  Raha
//
//  Created by ADAM on 25/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class ServicetypeCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    var serviceId = ""
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? String else { return }
        titleLbl.text = model
        if model == "" {
            titleLbl.text = "gift".localized
            containerView.backgroundColor = UIColor(hex: "#FFF4E5")
            titleLbl.textColor = UIColor(hex: "#FE9B0E")
        }else {
            containerView.backgroundColor = R.color.lightblue()
            titleLbl.textColor = R.color.normalblue()
        }
    }
    func setupselect() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? ServicetypeDatum else { return }
        containerView.cornerRadius = 12
        titleLbl.text = model.value ?? ""
        containerView.borderWidth = 1
        if serviceId == model.key ?? "" {
            containerView.borderColor = R.color.normalblue()
            containerView.backgroundColor = R.color.lightblue()
            titleLbl.textColor = R.color.normalblue()
        }else {
            containerView.borderColor = R.color.lightgray()
            containerView.backgroundColor = R.color.whiteColor()
            titleLbl.textColor = R.color.black3()
        }
    }
    
    func setupselectdetails() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? ServicetypeDatum else { return }
        containerView.cornerRadius = 4
        titleLbl.text = model.value ?? ""
        containerView.borderWidth = 0
        if serviceId == model.key ?? "" {
            containerView.borderColor = nil
            containerView.backgroundColor = R.color.normalblue()
            titleLbl.textColor = R.color.whiteColor()
        }else {
            containerView.borderColor = nil
            containerView.backgroundColor = R.color.whiteColor()
            titleLbl.textColor = R.color.black3()
        }
    }
}
