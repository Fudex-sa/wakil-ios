//
//  FullscreenVC.swift
//  Superfan
//
//  Created by ADAM on 29/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

// MARK: - ...  ViewController - Vars
class FullscreenVC: BaseController {
    @IBOutlet weak var gallaryCollection: UICollectionView!
    var viewModel: FullscreenViewModel?
    var coordinator: FullscreenCoordinator?
    var files: [File] = []
    var pos = 0
    var playerAv: AVPlayer?
    var playerController: AVPlayerViewController?
    var index = 0
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
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel = nil
        coordinator = nil
        playerAv?.pause()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.playVideo(at: 0)
        }
    }
    func playVideo(at index: Int) {
        if playerAv != nil {
            playerAv?.pause()
        }
        if files[safe: index]?.type ?? "" == "backgrounds" {
            return
        }
        guard var cell = gallaryCollection.cellForItem(at: IndexPath(row: index, section: 0)) as? ImagesCollectionViewCell else { return }
        guard let videoURL = URL(string: files[safe: index]?.value ?? "") else { return }
        playerAv = AVPlayer(url: videoURL)
        playerController = .init()
        playerController?.player = playerAv
        playerController?.view.frame.size.height = cell.vedioView.frame.size.height
        playerController?.view.frame.size.width = cell.vedioView.frame.size.width
        playerController?.showsPlaybackControls = false
        playerAv?.play()
        playerController?.videoGravity = .resize
        cell.vedioView.addSubview(playerController?.view ?? UIView())
        cell.playBtn.setImage(UIImage(named: "pause"), for: .normal)
        playerAv?.play()
       }
    @objc func playerDidFinishPlaying(video: NSNotification) {
        guard var cell = gallaryCollection.cellForItem(at: IndexPath(row: index, section: 0)) as? ImagesCollectionViewCell else { return }
        playerAv?.seek(to: .zero)
        playerAv?.pause()
        cell.playBtn.setImage(UIImage(named: "group-11334"), for: .normal)
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
        let visibleRect = CGRect(origin: gallaryCollection.contentOffset, size: gallaryCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = gallaryCollection.indexPathForItem(at: visiblePoint)
        index = visibleIndexPath?.row ?? 0
        playVideo(at: visibleIndexPath?.row ?? 0)
    }
  }

extension FullscreenVC : ImagesCollectionViewCellDelegate{
    func delete(wasPressedOnCell cell: ImagesCollectionViewCell, index: Int) {
        
    }
    func play(wasPressedOnCell cell: ImagesCollectionViewCell) {
        if playerAv?.timeControlStatus == .playing {
            playerAv?.pause()
            cell.playBtn.setImage(UIImage(named: "group-11334"), for: .normal)
        }else {
            playerAv?.play()
            cell.playBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
}
