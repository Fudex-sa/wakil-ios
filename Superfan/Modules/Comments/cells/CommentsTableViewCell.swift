//
//  CommentsTableViewCell.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
protocol CommentsTableViewCellDelegate: AnyObject {
    func clubdetails(wasPressedOnCell cell: CommentsTableViewCell , clubId : Int)
    func favoraite(wasPressedOnCell cell: CommentsTableViewCell , model : CommentsDatum)
    func comments(wasPressedOnCell cell: CommentsTableViewCell , model : CommentsDatum)
    func edit(wasPressedOnCell cell: CommentsTableViewCell , model : CommentsDatum)
    func delete(wasPressedOnCell cell: CommentsTableViewCell , model : CommentsDatum)
}
class CommentsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var topConstant: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyHight: NSLayoutConstraint!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    var delegate: CommentsTableViewCellDelegate?
    var isreply = false
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard var model = model as? CommentsDatum else { return }
        clubLbl.text = model.reactor?.name ?? ""
        clubImg.setImage(url: model.reactor?.logo ?? "")
        timeLbl.text = model.date ?? ""
        titlelbl.text = model.comment ?? ""
        liked(is: model.isLiked ?? 0)
        commentLbl.text = "\(model.commentersCount ?? 0) \("comment".localized)"
        likeLbl.text = "\(model.likersCount ?? 0) \("Interactions".localized)"
        if UD.user != nil {
            if UD.user?.data?.user?.id ?? 0 == model.reactor?.id ?? 0 {
                editBtn.isHidden = false
                deleteBtn.isHidden = false
            }else {
                editBtn.isHidden = true
                deleteBtn.isHidden = true
            }
        }
        if isreply {
            replyHight.constant = 0
            topConstant.constant = 0
            replyView.isHidden = true
            commentLbl.isHidden = true
            likeLbl.isHidden = true
        }else {
            topConstant.constant = 13
            replyView.isHidden = false
            replyHight.constant = 50
            commentLbl.isHidden = false
            likeLbl.isHidden = false
        }
        clubImg.UIViewAction {
//            if model.user?.type ?? "" != "3" && model.user?.type ?? "" != "4" {
//                return
//            }
//            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.user?.id ?? 0)
        }
        clubLbl.UIViewAction {
//            if model.user?.type ?? "" != "3" && model.user?.type ?? "" != "4" {
//                return
//            }
//            self.delegate?.clubdetails(wasPressedOnCell: self, clubId: model.user?.id ?? 0)
        }
        likeView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.favoraite(wasPressedOnCell: self, model: model)
            if UD.user != nil {
                if model.isLiked == 1 {
                    model.likersCount = (model.likersCount ?? 0) - 1
                    model.isLiked = 0
                } else {
                    model.likersCount = (model.likersCount ?? 0) + 1
                    model.isLiked = 1
                }
                self.liked(is: model.isLiked)
                self.likeLbl.text = "\(model.likersCount ?? 0) \("Interactions".localized)"
            }
        }).store(self)
        commentView.publisherGesture.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.comments(wasPressedOnCell: self, model: model)
        }).store(self)
        editBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.edit(wasPressedOnCell: self, model: model)
        }).store(self)
        deleteBtn.publisher.listen(on: {[weak self] _ in
            guard let self = self else { return }
            self.delegate?.delete(wasPressedOnCell: self, model: model)
        }).store(self)
        commentLbl.UIViewAction {
            self.delegate?.comments(wasPressedOnCell: self, model: model)
        }
       
    }
    func liked(is like: Int?) {
        if like == 1 {
            favImg.image = R.image.fav1()
        } else {
            favImg.image = R.image.heart2()
        }
    }
}
