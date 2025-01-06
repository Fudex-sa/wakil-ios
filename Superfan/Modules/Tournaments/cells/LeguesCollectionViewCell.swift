//
//  LeguesCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 02/01/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol LeguesCollectionViewCellDelegate: AnyObject {
    func select(wasPressedOnCell cell: LeguesCollectionViewCell , leagueId : Int  , type : Int)
}
class LeguesCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueView: UIView!
    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var legaueLbl: UILabel!
    var leagueId = 0
    var delegate: LeguesCollectionViewCellDelegate?
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? TournamentsDatum else { return }
        legaueLbl.text = model.name ?? ""
        leagueImg.setImage(url: model.image ?? "")
        if model.id ?? 0 == leagueId {
            leagueView.backgroundColor = R.color.primary()
            legaueLbl.textColor = R.color.darkwhite()
        }else {
            leagueView.backgroundColor = R.color.secondary1()
            legaueLbl.textColor = R.color.darkgray()
        }
        containerView.publisherGesture.listen(on: {[weak self] _ in
            self?.delegate?.select(wasPressedOnCell: self!, leagueId: model.id ?? 0, type: model.type ?? 1)
        }).store(self)
        
    }
}
