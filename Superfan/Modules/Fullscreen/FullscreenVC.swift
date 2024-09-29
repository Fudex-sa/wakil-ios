//
//  FullscreenVC.swift
//  Superfan
//
//  Created by ADAM on 29/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FullscreenVC: BaseController {
    @IBOutlet weak var gallaryCollection: UICollectionView!
    var viewModel: FullscreenViewModel?
    var coordinator: FullscreenCoordinator?
    var files: [File] = []
    var pos = 0
}

// MARK: - ...  LifeCycle
extension FullscreenVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = .init()
        coordinator = .init()
        coordinator?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        stopPlayersInVisibleCells()
    }
}
// MARK: - ...  Functions
extension FullscreenVC {
    func setup() {
        gallaryCollection.delegate = self
        gallaryCollection.dataSource = self
        gallaryCollection.observe()
        gallaryCollection.skeleton()
        gallaryCollection.reloadData()
        let indexPath = IndexPath(item: self.pos, section: 0)
        self.gallaryCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    func stopPlayersInVisibleCells() {
            for cell in gallaryCollection.visibleCells {
                if let myCell = cell as? ImagesCollectionViewCell {
                    myCell.stopPlayer()
                }
            }
        }
}
// MARK: - ...  View Contract
extension FullscreenVC {
}
extension FullscreenVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: gallaryCollection.width, height: gallaryCollection.height)
       }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return files.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell = collectionView.cell(type: ImagesCollectionViewCell.self, indexPath)
            cell.model = files[safe: indexPath.row]
            cell.delegate = self
            cell.setuppost1()
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            // No spacing between cells to ensure they are adjacent
            return 0
    }
  }

extension FullscreenVC : ImagesCollectionViewCellDelegate{
    func delete(wasPressedOnCell cell: ImagesCollectionViewCell, index: Int) {
        
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
