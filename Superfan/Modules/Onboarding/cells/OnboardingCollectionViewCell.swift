//
//  OnboardingCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var onboardingImg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
}
