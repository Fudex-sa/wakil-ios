//
//  ImagesCollectionViewCell.swift
//  Superfan
//
//  Created by ADAM on 17/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class ImagesCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var vedioView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sliderImg: UIImageView!
    var playerAv: AVPlayer?
    var playerController: AVPlayerViewController?
    var playerItem: AVPlayerItem?
    override func setup() {
        skeleton(for: containerView)
        super.setup()
        guard let model = model as? NewsDetailBackgroud else { return }
        sliderImg.setImage(url: model.image ?? "")
    }
    func setuppost() {
        skeleton(for: containerView)
        guard let model = model as? File else { return }
        if model.type ?? "" == "backgrounds" {
            sliderImg.setImage(url: model.value ?? "")
            vedioView.isHidden = true
            playBtn.isHidden = true
            sliderImg.isHidden = false
        }else {
            guard let url = URL(string: model.value ?? "") else { return }
            playerItem = .init(url: url)
            playerAv = .init(playerItem: playerItem)
            playerController = .init()
            playerController?.player = playerAv
            playerController?.view.frame.size.height = vedioView.frame.size.height
            playerController?.view.frame.size.width = vedioView.frame.size.width
            playerController?.showsPlaybackControls = false
            playerAv?.pause()
            playerController?.videoGravity = .resize
            self.vedioView.addSubview(playerController?.view ?? UIView())
            self.vedioView.addSubview(createOpacityView())
            vedioView.isHidden = false
            sliderImg.isHidden = true
            playBtn.isHidden = false
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        }
        playBtn.publisher.listen { [weak self] in
            self?.playaction()
        }.store(self)
    }
    func createOpacityView() -> UIView {
        let view = UIView()
        view.backgroundColor = R.color.blackshadow8()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            view.fillSuperView()
        }
        return view
    }
    func playaction() {
        if self.playerAv == nil {
            return
        }
        if self.playerAv?.timeControlStatus == .playing {
            self.playerAv?.pause()
            self.playBtn.setImage(UIImage(named: "group-11334"), for: .normal)
        } else {
            self.playerAv?.play()
            self.playBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    func restartPlay() {
        playerAv?.seek(to: .zero)
        playerAv?.pause()
        self.playBtn.setImage(UIImage(named: "group-11334"), for: .normal)
    }
    @objc func playerDidFinishPlaying(video: NSNotification) {
        restartPlay()
        print("Video Finished")
    }
}
