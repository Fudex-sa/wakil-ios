//
//  MatchdetailsVC.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MatchdetailsVC: BaseController {
    @IBOutlet weak var statsticTbl: UITableView!
    @IBOutlet weak var statsticLbl: UILabel!
    @IBOutlet weak var dateLbl: PaddingLabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var statusLbl: PaddingLabel!
    @IBOutlet weak var club2PlayerLbl: UILabel!
    @IBOutlet weak var club2Lbl: UILabel!
    @IBOutlet weak var club2Img: UIImageView!
    @IBOutlet weak var clubPlayerLbl: UILabel!
    @IBOutlet weak var club1Lbl: UILabel!
    @IBOutlet weak var club1Img: UIImageView!
    var viewModel: MatchdetailsViewModel?
    var coordinator: MatchdetailsCoordinator?
    var matchId = 0
    var statisctic : [statistecModel] = []
}

// MARK: - ...  LifeCycle
extension MatchdetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
        bind()
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.matchdata.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension MatchdetailsVC {
    func setup() {
        statsticTbl.delegate = self
        statsticTbl.dataSource = self
        statsticTbl.observe()
        statsticTbl.skeleton()
        startLoading()
        viewModel?.matchId.send(matchId)
        viewModel?.getmatchdetails()
        club1Img.UIViewAction {
            self.coordinator?.detailsclub(id: self.viewModel?.matchdata.value?.data?.team1?.id ?? 0)
        }
        club2Img.UIViewAction {
            self.coordinator?.detailsclub(id: self.viewModel?.matchdata.value?.data?.team2?.id ?? 0)
        }
        club1Lbl.UIViewAction {
            self.coordinator?.detailsclub(id: self.viewModel?.matchdata.value?.data?.team1?.id ?? 0)
        }
        club2Lbl.UIViewAction {
            self.coordinator?.detailsclub(id: self.viewModel?.matchdata.value?.data?.team2?.id ?? 0)
        }
    }
    func reload() {
        stopLoading()
        statisctic.removeAll()
        club1Img.setImage(url: viewModel?.matchdata.value?.data?.team1?.logo ?? "")
        club2Img.setImage(url: viewModel?.matchdata.value?.data?.team2?.logo ?? "")
        club1Lbl.text = viewModel?.matchdata.value?.data?.team1?.title ?? ""
        club2Lbl.text = viewModel?.matchdata.value?.data?.team2?.title ?? ""
        dateLbl.text = viewModel?.matchdata.value?.data?.date ?? ""
        statusLbl.text = viewModel?.matchdata.value?.data?.liveStatus ?? ""
        if viewModel?.matchdata.value?.data?.status == 1 {
            resultLbl.text =  "- : -"
            statsticLbl.text = "Statistics after match".localized
            statsticTbl.isHidden = true
            return
        }else {
            statsticLbl.text = "Match Statistics".localized
            resultLbl.text = "\(viewModel?.matchdata.value?.data?.team1?.score ?? 0) : \(viewModel?.matchdata.value?.data?.team2?.score ?? 0)"
        }
        statisctic.append(statistecModel(title: "Total Shots".localized, result1: viewModel?.matchdata.value?.data?.team1?.shots?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.shots?.string ?? ""))
        statisctic.append(statistecModel(title: "Total shots on goal".localized, result1: viewModel?.matchdata.value?.data?.team1?.targetShots?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.targetShots?.string ?? ""))
        statisctic.append(statistecModel(title: "Possession of the ball".localized, result1: "\(viewModel?.matchdata.value?.data?.team1?.possession?.string ?? "")%", result2: "\(viewModel?.matchdata.value?.data?.team2?.possession?.string ?? "")%"))
        statisctic.append(statistecModel(title: "Passes".localized, result1: viewModel?.matchdata.value?.data?.team1?.pass?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.pass?.string ?? ""))
        statisctic.append(statistecModel(title: "Pass accuracy, pass correctness".localized, result1: "\(viewModel?.matchdata.value?.data?.team1?.passAccuracy?.string ?? "")%", result2: "\(viewModel?.matchdata.value?.data?.team2?.passAccuracy?.string ?? "")%"))
        statisctic.append(statistecModel(title: "Fouls".localized, result1: viewModel?.matchdata.value?.data?.team1?.fouls?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.fouls?.string ?? ""))
        statisctic.append(statistecModel(title: "Yellow card".localized, result1: viewModel?.matchdata.value?.data?.team1?.yellowCards?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.yellowCards?.string ?? ""))
        statisctic.append(statistecModel(title: "Red Card".localized, result1: viewModel?.matchdata.value?.data?.team1?.redCards?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.redCards?.string ?? ""))
        statisctic.append(statistecModel(title: "Offside".localized, result1: viewModel?.matchdata.value?.data?.team1?.offsides?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.offsides?.string ?? ""))
        statisctic.append(statistecModel(title: "Corner kick".localized, result1: viewModel?.matchdata.value?.data?.team1?.corners?.string ?? "", result2: viewModel?.matchdata.value?.data?.team2?.corners?.string ?? ""))
        statsticTbl.reloadData()
    }
}
// MARK: - ...  View Contract
extension MatchdetailsVC {
}
extension MatchdetailsVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisctic.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: MatchdetailsTableViewCell.self, indexPath)
        cell.model = statisctic[safe: indexPath.row]
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
