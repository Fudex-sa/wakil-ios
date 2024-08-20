//
//  SelectclubVC.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SelectclubVC: BaseController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var clubsCollection: UICollectionView!
    var viewModel: SelectclubViewModel?
    var coordinator: SelectclubCoordinator?
    var clubId = 0
    var club : SelectclubDatum?
}

// MARK: - ...  LifeCycle
extension SelectclubVC {
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
        
        viewModel?.requestFinished.listen(on: { [weak self] value in
            self?.reload()
        })
        viewModel?.favclub.listen(on: { [weak self] value in
            self?.stopLoading()
            UD.club = self?.club
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        })
       
    }
}
// MARK: - ...  Functions
extension SelectclubVC {
    func setup() {
        clubsCollection.delegate = self
        clubsCollection.dataSource = self
        viewModel?.countryId.send(1)
        clubsCollection.observe()
        clubsCollection.skeleton()
        viewModel?.resetPaginator()
        viewModel?.clearDataSource()
        viewModel?.fetchclubs()
        skipBtn.publisher.listen(on: {[weak self] _ in
            UD.club = nil
            Coordinator.instance.restart(storyboard: R.storyboard.mainStoryboard())
        }).store(self)
        nextBtn.publisher.listen(on: {[weak self] _ in
            self?.startLoading()
            self?.viewModel?.clubId.send(self?.clubId ?? 0)
            self?.viewModel?.makefavcliub()
        }).store(self)
    }
    func reload(){
        if viewModel?.items.value?.count ?? 0 == 0 {
            clubsCollection.isHidden = true
            showEmptyScreen(for: 250 , title: "There are no clubs available".localized)
        }else {
            clubsCollection.isHidden = false
            hideEmptyScreen()
        }
        clubsCollection.reloadData()
        clubsCollection.stopSwipeButtom()

    }
}
// MARK: - ...  View Contract
extension SelectclubVC {
}
extension SelectclubVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = collectionViewWidth / 3 - 10
        return CGSize(width: itemWidth , height: 105)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel?.items.value?.count ?? 6
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ClubCollectionViewCell.self, indexPath)
            cell.clubId = clubId
            cell.model = viewModel?.items.value?[safe: indexPath.row]
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.items.value?.count ?? 0 == 0 {
            return
        }
        nextBtn.backgroundColor = R.color.primary()
        nextBtn.isUserInteractionEnabled = true
        clubId = viewModel?.items.value?[safe: indexPath.row]?.id ?? 0
        club = viewModel?.items.value?[safe: indexPath.row]
        clubsCollection.reloadData()
    }
  }
