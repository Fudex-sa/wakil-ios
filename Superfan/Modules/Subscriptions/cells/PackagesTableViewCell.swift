//
//  PackagesTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol PackagesTableViewCellDelegate: AnyObject {
    func delete(wasPressedOnCell cell: PackagesTableViewCell , model : MysubscribeDatum)

}
class PackagesTableViewCell: BaseTableViewCell {
    @IBOutlet weak var unsubscribeBtn: UIButton!
    @IBOutlet weak var FeatureHight: NSLayoutConstraint!
    @IBOutlet weak var featureView: UIView!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    @IBOutlet weak var buttomHight: NSLayoutConstraint!
    @IBOutlet weak var conatinerView: UIView!
    var delegate: PackagesTableViewCellDelegate?
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var featuresTbl: UITableView!
    @IBOutlet weak var clubHight: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubView: RoundedView!
    var features: [String] = []
    var clubId = 0
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard var model = model as? PackageDatum else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.logo ?? "")
        titleLbl.text = model.title ?? ""
        priceLbl.text = "\(model.price ?? 0) \("SAR".localized) / \(model.monthesCount ?? 0) \("Months".localized)"
        if clubId != 0 {
            clubView.isHidden = true
            clubHight.constant = 0
            lineView.isHidden = true
        }else {
            clubView.isHidden = false
            clubHight.constant = 34
            lineView.isHidden = false
        }
        colorLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        features.removeAll()
        features.append(contentsOf: model.features ?? [])
        FeatureHight.constant = CGFloat((features.count) * 30)
        featuresTbl.delegate = self
        featuresTbl.dataSource = self
        featuresTbl.reloadData()
        //updateTableViewHeight()
    }
     func setupmysubscribe() {
        skeleton(view: contentView)
        guard var model = model as? MysubscribeDatum else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.logo ?? "")
        titleLbl.text = model.title ?? ""
        priceLbl.text = "\(model.price ?? 0) \("SAR".localized) / \(model.monthesCount ?? 0) \("Months".localized)"
        
         colorLbl.textColor = R.color.primary()
         colorLbl.text = "\("Expires in".localized) \(model.expireDate ?? "")"
        features.removeAll()
        features.append(contentsOf: model.features ?? [])
        FeatureHight.constant = CGFloat((features.count) * 30)
        featuresTbl.delegate = self
        featuresTbl.dataSource = self
        featuresTbl.reloadData()
         unsubscribeBtn.isHidden = false
         unsubscribeBtn.publisher.listen(on: {[weak self] _ in
             guard let self = self else { return }
             self.delegate?.delete(wasPressedOnCell: self, model: model)
         }).store(self)
        //updateTableViewHeight()
    }
    func updateTableViewHeight() {
        DispatchQueue.main.async {
            self.featureView.layoutIfNeeded()
            let contentHeight = self.featuresTbl.contentSize.height
            self.viewHight.constant = contentHeight + 30
        }
    }
}
extension PackagesTableViewCell:UITableViewDelegate , UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: FeaturesTableViewCell.self, indexPath)
        cell.model = features[safe: indexPath.row]
        cell.setup()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }

}
