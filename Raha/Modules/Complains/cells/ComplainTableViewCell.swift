//
//  ComplainTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class ComplainTableViewCell: BaseTableViewCell {
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyHight: NSLayoutConstraint!
    @IBOutlet weak var replyLbl: UILabel!
    @IBOutlet weak var replyStackView: UIStackView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var containerView: UIView!
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? ComplainsDatum else { return }
        idLbl.text = "#\(model.id ?? 0)"
        if model.status ?? 0 == 1 {
            statusLbl.text = "New1".localized
            statusView.backgroundColor = R.color.lightblue()
            statusLbl.textColor = R.color.normalblue()
        }else if model.status ?? 0 == 2 {
            statusLbl.text = "Under review".localized
            statusView.backgroundColor = UIColor(hex: "#FBE5D9")
            statusLbl.textColor = R.color.orange()
        }else if model.status ?? 0 == 3 {
            statusLbl.text = "Closed".localized
            statusView.backgroundColor = UIColor(hex: "#D8FDED")
            statusLbl.textColor = UIColor(hex: "#0C9D61")
        }
        messageLbl.text = model.message ?? ""
        replyLbl.text = model.reply ?? ""
        if model.reply ?? "" == "" {
            replyStackView.isHidden = true
            replyHight?.isActive = false
            replyHight = replyView.heightAnchor.constraint(equalToConstant: 0)
            replyHight?.isActive = true
        }else {
            replyStackView.isHidden = false
            replyHight?.isActive = false
            replyHight = replyView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
            replyHight?.isActive = true
        }
    }
}
