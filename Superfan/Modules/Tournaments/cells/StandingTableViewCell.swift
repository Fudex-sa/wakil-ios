//
//  StandingTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 05/01/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit

class StandingTableViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var standingHight: NSLayoutConstraint!
    @IBOutlet weak var standingTbl: UITableView!
    var model: StandingsMultiModel?
    override func setup() {
        super.setup()
        titleLbl.text = model?.title ?? ""
        standingTbl.delegate = self
        standingTbl.dataSource = self
        standingTbl.observe()
        standingTbl.skeleton()
        standingHight.constant = CGFloat(((model?.data?.count ?? 0) * 40 ) + 50)
        standingTbl.reloadData()
        
    }
}
extension StandingTableViewCell:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.data?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: TableTableViewCell.self, indexPath)
        cell.model = model?.data?[safe: indexPath.row]
        cell.setup()
        return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
