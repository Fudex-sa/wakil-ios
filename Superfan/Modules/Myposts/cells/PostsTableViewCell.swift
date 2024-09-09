//
//  PostsTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol PostsTableViewCellDelegate: AnyObject {
    func clubdetails(wasPressedOnCell cell: PostsTableViewCell , clubId : Int)
}
class PostsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var imageHight: NSLayoutConstraint!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    var delegate: PostsTableViewCellDelegate?
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard let model = model as? PostsDatum else { return }
        clubLbl.text = model.user?.name ?? ""
        clubImg.setImage(url: model.user?.logo ?? "")
        timeLbl.text = model.date ?? ""
        titlelbl.text = model.description ?? ""
        postImg.setImage(url: model.backgroundImg ?? "")
        if model.backgroundImg ?? "" == "" {
            imageHight.constant = 0
        }else {
            imageHight.constant = 160
        }
        commentLbl.text = "\(model.commentersCount ?? 0) \("comment".localized)"
        likeLbl.text = "\(model.likersCount ?? 0) \("Interactions".localized)"
        clubImg.UIViewAction {
            if model.user?.type ?? "" != "3" && model.user?.type ?? "" != "4" {
                return
            }
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.user?.id ?? 0)
        }
        clubLbl.UIViewAction {
            if model.user?.type ?? "" != "3" && model.user?.type ?? "" != "4" {
                return
            }
            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.user?.id ?? 0)
        }
    }
}
