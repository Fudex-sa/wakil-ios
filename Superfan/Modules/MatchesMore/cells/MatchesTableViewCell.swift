//
//  MatchesTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol MatchesTableViewCellDelegate: AnyObject {
    func clubdetails(wasPressedOnCell cell: MatchesTableViewCell , clubId : Int)
}
class MatchesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var contanerView: UIView!
    @IBOutlet weak var club1Img: UIImageView!
    @IBOutlet weak var club1Lbl: UILabel!
    @IBOutlet weak var club2Img: UIImageView!
    @IBOutlet weak var club2Lbl: UILabel!
    @IBOutlet weak var legaueLbl: UILabel!
    @IBOutlet weak var resulteLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var delegate: MatchesTableViewCellDelegate?
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
            timeLbl.textColor = R.color.primary()
            timeView.backgroundColor = UIColor(hex: "#FFF3F5")
        }else if model.status ?? 0 == 1 {
            timeView.isHidden = false
            resulteLbl.text = "- : -"
            timeLbl.text = DateHelper().date(date: model.date ?? "", format: "hh:mm a", oldFormat: "yyyy-MM-dd HH:mm:ss")
            timeLbl.textColor = R.color.black1()
            timeView.backgroundColor = UIColor(hex: "#F3F4F5")
        }else {
            timeView.isHidden = false
            if Localizer.current == .arabic{
                resulteLbl.text = "\(model.team2?.score ?? 0) : \(model.team1?.score ?? 0)"

            }else {
                resulteLbl.text = "\(model.team1?.score ?? 0) : \(model.team2?.score ?? 0)"

            }
            timeLbl.text = model.liveStatus ?? ""
            timeLbl.textColor = R.color.primary()
            timeView.backgroundColor = UIColor(hex: "#FFF3F5")
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
