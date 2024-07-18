//
//  NewsDetailsVC.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NewsDetailsVC: BaseController {
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var clubLbl: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var sliderCollection: UICollectionView!
    var viewModel: NewsDetailsViewModel?
    var coordinator: NewsDetailsCoordinator?
    var newsId = 0
}

// MARK: - ...  LifeCycle
extension NewsDetailsVC {
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
        sliderCollection.autoScrolling()
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
        
        viewModel?.newsdata.listen(on: { [weak self] value in
            self?.reload()
        })
       
    }
}
// MARK: - ...  Functions
extension NewsDetailsVC {
    func setup() {
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        sliderCollection.observe()
        sliderCollection.skeleton()
        startLoading()
        viewModel?.newsId.send(newsId)
        viewModel?.getnewsdetails()
    }
    func reload() {
        stopLoading()
        clubImg.setImage(url: viewModel?.newsdata.value?.data?.club?.photo ?? "")
        clubLbl.text = viewModel?.newsdata.value?.data?.club?.name ?? ""
        timeLbl.text = viewModel?.newsdata.value?.data?.date ?? ""
        desLbl.text = viewModel?.newsdata.value?.data?.description ?? ""
        if viewModel?.newsdata.value?.data?.backgrouds?.count ?? 0 == 0 {
            sliderCollection.isHidden = true
        }
        sliderCollection.reloadData()
    }
}
// MARK: - ...  View Contract
extension NewsDetailsVC {
}
extension NewsDetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: sliderCollection.width, height: sliderCollection.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel?.newsdata.value?.data?.backgrouds?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
            cell.model = viewModel?.newsdata.value?.data?.backgrouds?[safe: indexPath.row]
            cell.setup()
            return cell
        }
   
  }
