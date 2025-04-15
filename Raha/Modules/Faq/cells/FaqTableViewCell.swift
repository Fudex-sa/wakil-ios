//
//  FaqTableViewCell.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol FaqTableViewCellDelegate: AnyObject {
    func selectfaq(wasPressedOnCell cell: FaqTableViewCell , model : faqdataModel)}
class FaqTableViewCell: BaseTableViewCell {
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var answerLbl: UILabel!
    var delegate: FaqTableViewCellDelegate?
    var isControl: Bool = false
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? faqdataModel else { return }
        titleLbl.text = model.question ?? ""
        answerLbl.text = model.answer ?? ""
        if model.isselect ?? false {
            arrowImg.image = R.image.arrowdown()
            answerLbl.text = ""
        }else {
            arrowImg.image = R.image.arrowup()
            answerLbl.text = model.answer ?? ""
        }
        containerView.publisherGesture.listen(on: {[weak self]_ in
            self?.delegate?.selectfaq(wasPressedOnCell: self!, model: self?.model as! faqdataModel)
        }).store(self)
    }
}
