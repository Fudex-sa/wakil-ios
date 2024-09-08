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
        self.tabBarController?.tabBar.isHidden = true
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
        
        viewModel?.postdata.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension PostdetailsVC {
    func setup() {
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        sliderCollection.observe()
        sliderCollection.skeleton()
        startLoading()
        viewModel?.postId.send(postId)
        viewModel?.getpostdetails()
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
    }
    func reload() {
        stopLoading()
        clubImg.setImage(url: viewModel?.postdata.value?.data?.user?.logo ?? "")
        clubLbl.text = viewModel?.postdata.value?.data?.user?.name ?? ""
        timeLbl.text = viewModel?.postdata.value?.data?.date ?? ""
        desLbl.text = viewModel?.postdata.value?.data?.description?.htmlToString ?? ""
        if viewModel?.postdata.value?.data?.files?.count ?? 0 == 0 {
            sliderCollection.isHidden = true
        }
        sliderCollection.reloadData()
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
            cell.setuppost()
            return cell
        }
   
  }
