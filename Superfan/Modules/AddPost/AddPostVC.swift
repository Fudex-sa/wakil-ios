//
//  AddPostVC.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI
// MARK: - ...  ViewController - Vars
class AddPostVC: BaseController {
    enum VerifyType {
        case add
        case edit
    }
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var gallaryCollection: UICollectionView!
    @IBOutlet weak var vedioView: UIView!
    @IBOutlet weak var gallayView: UIView!
    @IBOutlet weak var desTxf: UITextView!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var viewModel: AddPostViewModel?
    var coordinator: AddPostCoordinator?
    var files: [AddPostModel] = []
    var picker: GalleryPickerHelper?
    var postdata: PostdetailsModel?
    var type: VerifyType = .add
    var path = 0
    var currentlyPlayingCell: ImagesCollectionViewCell?
 }

// MARK: - ...  LifeCycle
extension AddPostVC {
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
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        stopPlayersInVisibleCells()
    }
    override func bind() {
        super.bind()
        viewModel?.error.listen(on: { [weak self] error in
            self?.stopLoading()
            self?.didError(error: error?.localizedDescription)
        })
        
        viewModel?.addpostdata.listen(on: { [weak self] value in
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.addpostdata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
        })
        viewModel?.deletedata.listen(on: { [weak self] value in
            self?.files.remove(at: self?.path ?? 0)
            self?.gallaryCollection.reloadData()
            NotificationBuilder()
                .setTitle("Success".localized)
                .setBody(self?.viewModel?.deletedata.value?.message ?? "")
                .setTheme(.success)
                .bulid()
            self?.stopLoading()
        })
    }
    func stopPlayersInVisibleCells() {
            for cell in gallaryCollection.visibleCells {
                if let myCell = cell as? ImagesCollectionViewCell {
                    myCell.stopPlayer()
                }
            }
        }
}
// MARK: - ...  Functions
extension AddPostVC {
    func setup() {
        changeColoe()
        gallaryCollection.delegate = self
        gallaryCollection.dataSource = self
        gallaryCollection.observe()
        gallaryCollection.skeleton()
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            self.files.append(AddPostModel(id: 0, url: "", type: "backgrounds", path: url?.absoluteString ?? "",uri: nil))
            self.gallaryCollection.reloadData()
                    
        }
        picker?.onPickImage = { [self] image in
        }
        userImg.setImage(url: UD.user?.data?.user?.photo ?? "")
        userLbl.text = UD.user?.data?.user?.name ?? ""
        desTxf.delegate = self
        desTxf.textColor = R.color.whiteColor()
        if type == .edit {
            desTxf.text = postdata?.data?.description ?? ""
            viewModel?.postId.send(postdata?.data?.id ?? 0)
            for index in postdata?.data?.files ?? [] {
                self.files.append(AddPostModel(id: index.id ?? 0 , url: index.value ?? "" , type: index.type ?? ""  , path: "",uri: nil))
            }
            desTxf.textColor = R.color.black()
        }
        gallayView.publisherGesture.listen(on: {[weak self] _ in
            self?.picker?.pick(in: self)
        }).store(self)
        vedioView.publisherGesture.listen(on: {[weak self] _ in
            if self?.authroize(.camera, .photoLibrary) == false {
                self?.access(.camera, .photoLibrary)
                return
            }
            self?.attachVideo()
        }).store(self)
        sendBtn.publisher.listen(on: {[weak self] _ in
           
            var error = ""
            if self?.desTxf.text == self?.desTxf.localization || self?.desTxf.text == "" {
                error = "Write what you think ...".localized
            }
           
            if error == "" {
                self?.startLoading()
                self?.viewModel?.des.send(self?.desTxf.text ?? "")
                if self?.type == .add {
                    self?.viewModel?.files.send(self?.files ?? [])
                    self?.viewModel?.addpost()
                }else {
                    var editfiles: [AddPostModel] = []
                    for index in self?.files ?? []{
                        if index.url == "" {
                            editfiles.append(index)
                        }
                    }
                    self?.viewModel?.files.send(editfiles)
                    self?.viewModel?.editpost()
                }
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
    func attachVideo() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        imagePickerController.videoExportPreset = AVAssetExportPresetPassthrough
        present(imagePickerController, animated: true, completion: nil)
    }
    func changeColoe() {
        if UD.club != nil {
            sendBtn.backgroundColor = UIColor(hex: UD.club?.color ?? "")
        }
    }
   
}
// MARK: - ...  View Contract
extension AddPostVC {
}
extension AddPostVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if desTxf.textColor == R.color.whiteColor() {
                desTxf.text = nil
                desTxf.textColor = R.color.whiteColor()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if desTxf.text.isEmpty {
                desTxf.textColor = R.color.whiteColor() // YOUR PREFERED PLACEHOLDER COLOR HERE
                desTxf.text =  "Write what you think ...".localized
            }
        }
           
}


extension AddPostVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 60 , height: collectionView.frame.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return files.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
            cell.model = files[safe: indexPath.row]
            cell.setupaddpost()
            cell.delegate = self
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 8
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let selectedCell = collectionView.cellForItem(at: indexPath) as! ImagesCollectionViewCell
//            if let playingCell = currentlyPlayingCell {
//                playingCell.stopPlayer()
//            }
//            selectedCell.playaction()
//            currentlyPlayingCell = selectedCell
//        }
   
  }

extension AddPostVC : ImagesCollectionViewCellDelegate{
    func delete(wasPressedOnCell cell: ImagesCollectionViewCell, index: Int) {
        if files[index].id == 0 {
            files.remove(at: index)
            gallaryCollection.reloadData()
        }else {
            path = index
            startLoading()
            viewModel?.mediaId.send(files[index].id)
            viewModel?.deletemedia()
        }
    }
    func play(wasPressedOnCell cell: ImagesCollectionViewCell) {
        for cell1 in gallaryCollection.visibleCells {
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
extension AddPostVC: Permission {
    internal func reload() {
        if authroize(.camera, .photoLibrary) {
            attachVideo()
        }
    }
}
extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: {
            guard let movieUrl = info[.mediaURL] as? URL else { return }
            self.files.append(AddPostModel(id: 0,url: "", type: "videos", path: movieUrl.lastPathComponent,uri: movieUrl))
            DispatchQueue.main.async {
                self.gallaryCollection.reloadData()
            }
        })
       
        
    }
}
