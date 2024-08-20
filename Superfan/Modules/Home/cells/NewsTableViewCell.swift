//
//  NewsTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol NewsTableViewCellDelegate: AnyObject {
    func clubdetails(wasPressedOnCell cell: NewsTableViewCell , clubId : Int)
}
class NewsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var newImg: UIImageView!
    var delegate: NewsTableViewCellDelegate?
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? NewsModelData else { return }
        clubLbl.text = model.club?.name ?? ""
        clubImg.setImage(url: model.club?.photo ?? "")
        timeLbl.text = model.date ?? ""
        titlelbl.text = model.title ?? ""
        newImg.setImage(url: model.backgrouds ?? "")
        if model.backgrouds ?? "" == "" {
            imageHight.constant = 0
        }else {
            imageHight.constant = 134
        }
        clubImg.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.club?.id ?? 0)
        }
        clubLbl.UIViewAction {
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.club?.id ?? 0)
        }
       
    }
}
