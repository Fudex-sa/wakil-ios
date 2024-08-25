//
//  MatchsHomeCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol MatchsHomeCollectionViewCellDelegate: AnyObject {
    func clubdetails(wasPressedOnCell cell: MatchsHomeCollectionViewCell , clubId : Int)
}
class MatchsHomeCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var contanerView: UIView!
    @IBOutlet weak var club1Img: UIImageView!
    @IBOutlet weak var club1Lbl: UILabel!
    @IBOutlet weak var club2Img: UIImageView!
    @IBOutlet weak var club2Lbl: UILabel!
    @IBOutlet weak var legaueLbl: UILabel!
    @IBOutlet weak var resulteLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var delegate: MatchsHomeCollectionViewCellDelegate?

    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? MatchsDatum else { return }
        club1Img.setImage(url: model.team1?.logo ?? "")
        club1Lbl.text = model.team1?.title ?? ""
        club2Img.setImage(url: model.team2?.logo ?? "")
        club2Lbl.text = model.team2?.title ?? ""
        legaueLbl.text = model.leagueName ?? ""
        if model.status ?? 0 == 6 {
            timeView.isHidden = false
            if Localizer.current == .arabic{
                resulteLbl.text = "\(model.team2?.score ?? 0) : \(model.team1?.score ?? 0)"

            }else {
                resulteLbl.text = "\(model.team1?.score ?? 0) : \(model.team2?.score ?? 0)"

            }
            timeLbl.text = model.liveStatus ?? ""
            if UD.club != nil {
                timeLbl.textColor = UIColor(hex: UD.club?.color ?? "")
            }else {
                timeLbl.textColor = R.color.primary()
            }
        }else if model.status ?? 0 == 1 {
            timeView.isHidden = false
            resulteLbl.text = "- : -"
            timeLbl.text = DateHelper().date(date: model.date ?? "", format: "hh:mm a", oldFormat: "yyyy-MM-dd HH:mm:ss")
            timeLbl.textColor = R.color.primary()
        }else {
            timeView.isHidden = false
            if Localizer.current == .arabic{
                resulteLbl.text = "\(model.team2?.score ?? 0) : \(model.team1?.score ?? 0)"

            }else {
                resulteLbl.text = "\(model.team1?.score ?? 0) : \(model.team2?.score ?? 0)"

            }
            timeLbl.text = model.liveStatus ?? ""
            if UD.club != nil {
                timeLbl.textColor = UIColor(hex: UD.club?.color ?? "")
            }else {
                timeLbl.textColor = R.color.primary()
            }
        }
        club1Img.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.team1?.id ?? 0)
        }
        club2Img.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.team2?.id ?? 0)
        }
        club1Lbl.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.team1?.id ?? 0)
        }
        club2Lbl.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.team2?.id ?? 0)
        }
    }
}
