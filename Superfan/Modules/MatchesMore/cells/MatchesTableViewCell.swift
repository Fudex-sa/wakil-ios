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
    @IBOutlet weak var stackHight: NSLayoutConstraint!
    @IBOutlet weak var contanerView: UIView!
    @IBOutlet weak var club1Img: UIImageView!
    @IBOutlet weak var club1Lbl: UILabel!
    @IBOutlet weak var club2Img: UIImageView!
    @IBOutlet weak var club2Lbl: UILabel!
    @IBOutlet weak var legaueLbl: UILabel!
    @IBOutlet weak var resulteLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var player2Tbl: UITableView!
    @IBOutlet weak var Player1Tbl: UITableView!
    var delegate: MatchesTableViewCellDelegate?
    var matches: MatchsDatum?
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? MatchsDatum else { return }
        matches = model
        club1Img.setImage(url: model.team1?.logo ?? "")
        club1Lbl.text = model.team1?.title ?? ""
        club2Img.setImage(url: model.team2?.logo ?? "")
        club2Lbl.text = model.team2?.title ?? ""
        legaueLbl.text = model.leagueName ?? ""
        Player1Tbl.delegate = self
        Player1Tbl.dataSource = self
        Player1Tbl.observe()
        Player1Tbl.skeleton()
        player2Tbl.delegate = self
        player2Tbl.dataSource = self
        player2Tbl.observe()
        player2Tbl.skeleton()
        if model.status ?? 0 == 6 {
            if Localizer.current == .arabic{
                resulteLbl.text = "\(model.team2?.score ?? 0) : \(model.team1?.score ?? 0)"

            }else {
                resulteLbl.text = "\(model.team1?.score ?? 0) : \(model.team2?.score ?? 0)"

            }
            timeLbl.text = model.liveStatus ?? ""
            if model.team1?.scorers?.count ?? 0 >= model.team2?.scorers?.count ?? 0 {
                stackHight.constant = CGFloat((model.team1?.scorers?.count ?? 0) * 30)
            }else {
                stackHight.constant = CGFloat((model.team2?.scorers?.count ?? 0) * 30)
            }
        }else if model.status ?? 0 == 1 {
            resulteLbl.text = ""
            timeLbl.text = model.date ?? ""
            stackHight.constant = 0
        }else {
            if Localizer.current == .arabic{
                resulteLbl.text = "\(model.team2?.score ?? 0) : \(model.team1?.score ?? 0)"

            }else {
                resulteLbl.text = "\(model.team1?.score ?? 0) : \(model.team2?.score ?? 0)"

            }
            timeLbl.text = model.liveStatus ?? ""
            if model.team1?.scorers?.count ?? 0 >= model.team2?.scorers?.count ?? 0 {
                stackHight.constant = CGFloat((model.team1?.scorers?.count ?? 0) * 30)
            }else {
                stackHight.constant = CGFloat((model.team2?.scorers?.count ?? 0) * 30)
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
extension MatchesTableViewCell:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Player1Tbl {
            return matches?.team1?.scorers?.count ?? 0
        }else {
            return matches?.team2?.scorers?.count ?? 0   
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Player1Tbl {
            var cell = tableView.cell(type: PlayerteamTableViewCell.self, indexPath)
            cell.model = matches?.team1?.scorers?[safe: indexPath.row]
            cell.setup()
            return cell
        }else {
            var cell = tableView.cell(type: PlayerteamTableViewCell.self, indexPath)
            cell.model = matches?.team2?.scorers?[safe: indexPath.row]
            cell.setup()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
