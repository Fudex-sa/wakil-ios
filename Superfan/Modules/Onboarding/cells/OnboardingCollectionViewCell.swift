//
//  OnboardingCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol OnboardingCollectionViewCellDelegate: AnyObject {
    func next(wasPressedOnCell cell: OnboardingCollectionViewCell , Onboarding : OnboardingModel)
}
class OnboardingCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var onboardingImg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var delegate: OnboardingCollectionViewCellDelegate?

    override func setup() {
        super.setup()
        guard let model = model as? OnboardingModel else { return }
        titleLbl.text = model.title
        desLbl.text = model.des
        onboardingImg.image = UIImage(named: model.image)
        if model.id == 1 {
            step1View.backgroundColor = R.color.primary()
            step2View.backgroundColor = UIColor(hex: "#E1E1E1")
            step3View.backgroundColor = UIColor(hex: "#E1E1E1")
            nextBtn.setImage(R.image.next(), for: .normal)
        }else if model.id == 2 {
            step2View.backgroundColor = R.color.primary()
            step1View.backgroundColor = UIColor(hex: "#E1E1E1")
            step3View.backgroundColor = UIColor(hex: "#E1E1E1")
            nextBtn.setImage(R.image.done(), for: .normal)
        }else if model.id == 3 {
            step3View.backgroundColor = R.color.primary()
            step2View.backgroundColor = UIColor(hex: "#E1E1E1")
            step1View.backgroundColor = UIColor(hex: "#E1E1E1")
            nextBtn.setImage(R.image.done(), for: .normal)
        }
        nextBtn.publisher.listen(on: {[weak self] _ in
            self?.delegate?.next(wasPressedOnCell: self!, Onboarding: model)
        }).store(self)
    }
}
