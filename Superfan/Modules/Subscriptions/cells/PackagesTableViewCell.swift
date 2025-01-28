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
    func select(wasPressedOnCell cell: PackagesTableViewCell , model : PackageDatum)

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
    @IBOutlet weak var selecredView: UIView!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var selectHight: NSLayoutConstraint!
    @IBOutlet weak var selecttop: NSLayoutConstraint!
    var tax = ""
    var packageId = 0
    var features: [String] = []
    var clubId = 0
    override func setup() {
        super.setup()
        guard var model = model as? PackageDatum else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.logo ?? "")
        titleLbl.text = model.title ?? ""
        if model.id ?? 0 == packageId {
            selectHight.constant = 50
            selecttop.constant = 15
            selecredView.isHidden = false
            //conatinerView.borderColor = UIColor(hex: UD.club?.color ?? "#E51D35")
        }else {
            selectHight.constant = 0
            selecttop.constant = 0
            selecredView.isHidden = true
            //conatinerView.borderColor = R.color.gray()
        }
//        if UD.club != nil {
//            var color = UD.club?.color ?? ""
//            let index = color.index(color.startIndex, offsetBy: 1)
//            color = String(color.suffix(from: index))
//            selecredView.backgroundColor = UIColor(hex: "#15\(color)")
//        }else {
//            selecredView.backgroundColor = R.color.txtprimary()!
//        }
        selectLbl.text = "\("There is a tax of".localized) \(tax) \("SAR that will be added to the subscription value".localized)"
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
        conatinerView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.select(wasPressedOnCell: self, model: model)
        }).store(self)
        //updateTableViewHeight()
    }
     func setupmysubscribe() {
        guard var model = model as? MysubscribeDatum else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.logo ?? "")
        titleLbl.text = model.title ?? ""
        priceLbl.text = "\(model.price ?? 0) \("SAR".localized) / \(model.monthesCount ?? 0) \("Months".localized)"
        
         colorLbl.textColor = R.color.primary()
         colorLbl.text = "\("Expires in".localized) \(model.expireDate ?? "")"
         colorLbl.textColor = UIColor(hex: UD.club?.color ?? "#E51D35")
         unsubscribeBtn.borderColor = UIColor(hex: UD.club?.color ?? "#E51D35")
         unsubscribeBtn.setTitleColor(UIColor(hex: UD.club?.color ?? "#E51D35"), for: .normal)
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
