//
//  PostdetailsVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class PostdetailsVC: BaseController {
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    var viewModel: PostdetailsViewModel?
    var coordinator: PostdetailsCoordinator?
    var postId = 0
    var isbackstage = false
    var islike = 0
    private var currentPlayingCell: ImagesCollectionViewCell?

}

// MARK: - ...  LifeCycle
extension PostdetailsVC {
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
        (self.tabBarController as? CustomTabBarController)?.hideTabBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
       // stopPlayersInVisibleCells()
        stopAllVideos()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.postdata.listen(on: { [weak self] value in
            self?.reload()
        })
        viewModel?.deletedata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.deletedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
        })
        viewModel?.likedata.listen(on: { [weak self] value in
            if self?.islike ?? 0 == 1 {
                self?.islike = 0
                self?.likeBtn.setImage(R.image.heart2(), for: .normal)
            }else {
                self?.islike = 1
                self?.likeBtn.setImage(R.image.fav1(), for: .normal)
            }
        })
       
    }
    func stopPlayersInVisibleCells() {
            for cell in sliderCollection.visibleCells {
                if let myCell = cell as? ImagesCollectionViewCell {
                    myCell.stopPlayer()
                }
            }
        }
}
// MARK: - ...  Functions
extension PostdetailsVC {
    func setup() {
        changeColoe()
        if Localizer.current == .arabic {
            likeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            commentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            editBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
            closeBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        sliderCollection.observe()
        sliderCollection.skeleton()
        startLoading()
        viewModel?.postId.send(postId)
        if isbackstage == true {
            viewModel?.getbackstagesdetails()
        }else {
            viewModel?.getpostdetails()
        }
        clubImg.UIViewAction {
            if self.viewModel?.postdata.value?.data?.user?.type ?? "" != "3" && self.viewModel?.postdata.value?.data?.user?.type ?? "" != "4"{
                return
            }
            self.coordinator?.detailsclub(id: self.viewModel?.postdata.value?.data?.user?.id ?? 0)
        }
        clubLbl.UIViewAction {
            if self.viewModel?.postdata.value?.data?.user?.type ?? "" != "3" && self.viewModel?.postdata.value?.data?.user?.type ?? "" != "4"{
                return
            }
            self.coordinator?.detailsclub(id: self.viewModel?.postdata.value?.data?.user?.id ?? 0)
        }
        editBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.editpost()
        }).store(self)
        closeBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.deletepost()
        }).store(self)
        commentBtn.publisher.listen(on: {[weak self] _ in
            self?.coordinator?.comments(id: self?.postId ?? 0)
        }).store(self)
        likeBtn.publisher.listen(on: {[weak self] _ in
            if self?.isbackstage ?? false {
                if self?.islike ?? 0 == 1 {
                    self?.viewModel?.unlikebackstage()
                }else {
                    self?.viewModel?.likebackstage()
                }
            }else {
                if self?.islike ?? 0 == 1 {
                    self?.viewModel?.unlikepost()
                }else {
                    self?.viewModel?.likepost()
                }
            }
        }).store(self)
        shareBtn.publisher.listen(on: {[weak self] _ in
            Common().shareApp(items: [self?.viewModel?.postdata.value?.data?.description?.htmlToString ?? ""])
        }).store(self)
    }
    func changeColoe() {
        if UD.club != nil {
            editBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
            closeBtn.borderColor = UIColor(hex: UD.club?.color ?? "")
            closeBtn.setTitleColor(UIColor(hex: UD.club?.color ?? ""), for: .normal)
            closeBtn.tintColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
    func reload() {
        stopLoading()
        clubImg.setImage(url: viewModel?.postdata.value?.data?.user?.logo ?? "")
        clubLbl.text = viewModel?.postdata.value?.data?.user?.name ?? ""
        timeLbl.text = viewModel?.postdata.value?.data?.date ?? ""
        let attributedText = Constants().addLineSpacingAndAlignment(text: viewModel?.postdata.value?.data?.description?.htmlToString ?? "", lineSpacing: 8.0 , alignment: getTextAlignmentForLanguage())
        desLbl.attributedText = attributedText
        if viewModel?.postdata.value?.data?.files?.count ?? 0 == 0 {
            sliderCollection.isHidden = true
        }
        if UD.user != nil {
            if viewModel?.postdata.value?.data?.user?.id ?? 0 == UD.user?.data?.user?.id ?? 0  {
                editBtn.isHidden = false
                closeBtn.isHidden = false
            }
        }
        islike = viewModel?.postdata.value?.data?.isLiked ?? 0
        if islike == 1 {
            likeBtn.setImage(R.image.heart2(), for: .normal)
        }else {
            islike = 1
            likeBtn.setImage(R.image.fav1(), for: .normal)
        }
        sliderCollection.reloadData()
    }
    func getTextAlignmentForLanguage() -> NSTextAlignment {
        if UIView.userInterfaceLayoutDirection(for: desLbl.semanticContentAttribute) == .rightToLeft {
            return .right
        } else {
            return .left
        }
    }
}
// MARK: - ...  View Contract
extension PostdetailsVC {
}
extension PostdetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: sliderCollection.width, height: sliderCollection.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel?.postdata.value?.data?.files?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
            cell.model = viewModel?.postdata.value?.data?.files?[safe: indexPath.row]
            cell.delegate = self
            cell.setuppost()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
       
            return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.postdata.value?.data?.files?.count ?? 0 == 0 {
            return
        }
        guard let scene = R.storyboard.fullscreenStoryboard.fullscreenVC() else { return }
        scene.files = viewModel?.postdata.value?.data?.files ?? []
        scene.pos = indexPath.row ?? 0
        push(scene)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            playVisibleVideos()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVisibleVideos()
    }

        private func playVisibleVideos() {
            let visibleCells = sliderCollection.visibleCells.compactMap { $0 as? ImagesCollectionViewCell }
                   guard let visibleCell = visibleCells.first else { return }

                   if currentPlayingCell != visibleCell {
                       currentPlayingCell?.pause()
                       currentPlayingCell = visibleCell
                       currentPlayingCell?.play()
                   }
           
        }
    private func stopAllVideos() {
           currentPlayingCell?.pause()
           currentPlayingCell = nil
       }
  }

extension PostdetailsVC : ImagesCollectionViewCellDelegate{
    func delete(wasPressedOnCell cell: ImagesCollectionViewCell, index: Int) {
        
    }
    func play(wasPressedOnCell cell: ImagesCollectionViewCell) {
        for cell1 in sliderCollection.visibleCells {
            if let myCell = cell1 as? ImagesCollectionViewCell {
                if cell == myCell {
                    cell.playaction()
                }else {
                    myCell.playerAv?.pause()
                    myCell.playBtn.setImage(UIImage(named: "group-11334"), for: .normal)
                }
            }
        }
    }
}
