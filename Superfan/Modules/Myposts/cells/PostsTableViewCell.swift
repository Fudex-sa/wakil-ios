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
    private var isExpanded: Bool = false
    private var onExpandCollapse: (() -> Void)?
    private var fullText: String = ""
    override func setup() {
        skeleton(view: contentView)
        super.setup()
        guard var model = model as? PostsDatum else { return }
        clubLbl.text = model.user?.name ?? ""
        clubImg.setImage(url: model.user?.logo ?? "")
        timeLbl.text = model.date ?? ""
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
        commentLbl.UIViewAction {
            self.delegate?.comments(wasPressedOnCell: self, model: model)
        }
    }
    func liked(is like: Int?) {
        if like == 1 {
            favImg.image = R.image.fav1()
        } else {
            favImg.image = R.image.fav()
        }
    }
    func configure(with text: String, isExpanded: Bool, onExpandCollapse: @escaping () -> Void) {
            self.fullText = text.htmlToString
            self.isExpanded = isExpanded
            self.onExpandCollapse = onExpandCollapse

            updateTextView()
        }
    func updateTextView(){
        if fullText.count > 80 {
            if isExpanded {
                       // Show full text with "Show Less"
                let fullDisplayText = "\(fullText) \("Show Less".localized)"
                let attributedString = createClickableText(fullDisplayText, clickablePart: "Show Less".localized)
                titlelbl.attributedText = attributedString
            } else {
                       // Show truncated text with "Load More"
                let truncatedDisplayText = "\(String(fullText.prefix(80))) \("Load More".localized)"
                let attributedString = createClickableText(truncatedDisplayText, clickablePart: "Load More".localized)
                titlelbl.attributedText = attributedString
            }
        }else {
            titlelbl.text = fullText
        }
    }
    private func createClickableText(_ fullText: String, clickablePart: String) -> NSMutableAttributedString {
           let attributedString = NSMutableAttributedString(string: fullText)
           let clickableRange = (fullText as NSString).range(of: clickablePart)
           
        attributedString.addAttribute(.foregroundColor, value: R.color.gray1(), range: clickableRange)
           
           // Add tap gesture to handle the click
           let tapGesture = TapGestureRecognizer(target: self, action: #selector(textTapped(_:)))
           tapGesture.action = onExpandCollapse
           titlelbl.isUserInteractionEnabled = true
           titlelbl.addGestureRecognizer(tapGesture)
           return attributedString
       }

       // Handle tap on "Load More" or "Show Less"
       @objc private func textTapped(_ sender: TapGestureRecognizer) {
           sender.action?()
       }
}
class TapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> Void)?
}
