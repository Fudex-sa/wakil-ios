//
//  FaqTableViewCell.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class FaqTableViewCell: BaseTableViewCell {
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var answerLbl: UILabel!
    var isControl: Bool = false
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? faqdataModel else { return }
        titleLbl.text = model.question ?? ""
        answerLbl.text = model.answer ?? ""
        if (isControl ?? false){
            answerLbl.text = model.answer ?? ""
        }else {
            answerLbl.text = ""
        }
        containerView.publisherGesture.listen(on: {[weak self]_ in
            self?.isControl = !(self?.isControl ?? true)
            if (self?.isControl ?? false){
                self?.answerLbl.text = model.answer ?? ""
            }else {
                self?.answerLbl.text = ""

            }
        }).store(self)
    }
}
