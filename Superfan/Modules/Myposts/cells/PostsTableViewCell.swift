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
    func favoraite(wasPressedOnCell cell: PostsTableViewCell , model : PostsDatum)
    func comments(wasPressedOnCell cell: PostsTableViewCell , model : PostsDatum)

}
class PostsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var favImg: UIImageView!
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
        guard var model = model as? PostsDatum else { return }
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
        liked(is: model.is_liked ?? 0)
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
        likeView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.favoraite(wasPressedOnCell: self, model: model)
            if UD.user != nil {
                if model.is_liked == 1 {
                    model.likersCount = (model.likersCount ?? 0) - 1
                    model.is_liked = 0
                } else {
                    model.likersCount = (model.likersCount ?? 0) + 1
                    model.is_liked = 1
                }
                self.liked(is: model.is_liked)
                self.likeLbl.text = "\(model.likersCount ?? 0) \("Interactions".localized)"
            }
        }).store(self)
        commentView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.comments(wasPressedOnCell: self, model: model)
        }).store(self)
    }
    func liked(is like: Int?) {
        if like == 1 {
            favImg.image = R.image.fav1()
        } else {
            favImg.image = R.image.fav()
        }
    }
}
