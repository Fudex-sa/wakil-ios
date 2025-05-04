//
//  NotsTableViewCell.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import UIKit
protocol NotsTableViewCellDelegate: AnyObject {
    func click(wasPressedOnCell cell: NotsTableViewCell , model : Notificationdata)
}
class NotsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var notHight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var notTbl: UITableView!
    var nots : [Notificationdata] = []
    var delegate: NotsTableViewCellDelegate?
    override func setup() {
        super.setup()
        skeleton(view: containerView)
        guard let model = model as? NotificationDatum else { return }
        dateLbl.text = model.date ?? ""
        notTbl.skeleton()
        notTbl.delegate = self
        notTbl.dataSource = self
        notTbl.observe()
        nots.removeAll()
        nots.append(contentsOf: model.notifications ?? [])
        notHight.constant = CGFloat(nots.count * 75)
        notTbl.reloadData()
    }
    
}
extension NotsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: Nots1TableViewCell.self, indexPath)
        cell.model = nots[safe: indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.click(wasPressedOnCell: self, model: nots[safe: indexPath.row]!)
    }
    
}
