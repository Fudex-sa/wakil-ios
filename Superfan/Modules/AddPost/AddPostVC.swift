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
class AddPostVC: BaseController , PHPickerViewControllerDelegate {
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
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
       
    }
}
// MARK: - ...  Functions
extension AddPostVC {
    func setup() {
        gallaryCollection.delegate = self
        gallaryCollection.dataSource = self
        gallaryCollection.observe()
        gallaryCollection.skeleton()
        picker = .init()
        picker?.onPickImageURL = { [self] url in
            self.files.append(AddPostModel(url: "", type: "backgrounds", path: url?.absoluteString ?? ""))
            self.gallaryCollection.reloadData()
                    
        }
        picker?.onPickImage = { [self] image in
        }
        
        userImg.setImage(url: UD.user?.data?.user?.photo ?? "")
        userLbl.text = UD.user?.data?.user?.name ?? ""
        desTxf.delegate = self
        desTxf.textColor = R.color.gray1()
        gallayView.publisherGesture.listen(on: {[weak self] _ in
            self?.picker?.pick(in: self)
        }).store(self)
        vedioView.publisherGesture.listen(on: {[weak self] _ in
            self?.selectVideosFromGallery()
        }).store(self)
        sendBtn.publisher.listen(on: {[weak self] _ in
           
            var error = ""
            if self?.desTxf.text == self?.desTxf.localization || self?.desTxf.text == "" {
                error = "Write what you think ...".localized
            }
           
            if error == "" {
                self?.startLoading()
                self?.viewModel?.des.send(self?.desTxf.text ?? "")
                self?.viewModel?.files.send(self?.files ?? [])
                self?.viewModel?.addpost()
            }else {
                self?.didError(error: error)
            }
        }).store(self)
    }
    func selectVideosFromGallery() {
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.filter = .videos // Only videos
            configuration.selectionLimit = 1 // Limit to 1 video (can be adjusted)

            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
           
        }
        
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)

            for result in results {
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                    if let videoURL = url {
                        self.files.append(AddPostModel(url: "", type: "videos", path: videoURL.absoluteString))
                        self.gallaryCollection.reloadData()
                        print("Selected video URL: \(videoURL)")
                        // Handle the selected video URL here (e.g., play or upload).
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        }
}
// MARK: - ...  View Contract
extension AddPostVC {
}
extension AddPostVC : UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            if desTxf.textColor == R.color.gray1() {
                desTxf.text = nil
                desTxf.textColor = R.color.black()
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if desTxf.text.isEmpty {
                desTxf.textColor = R.color.gray1() // YOUR PREFERED PLACEHOLDER COLOR HERE
                desTxf.text =  "Write what you think ...".localized
            }
        }
           
}


extension AddPostVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 60 , height: 60)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return files.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
            cell.model = files[safe: indexPath.row]
            cell.setupaddpost()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 8
    }
   
  }
