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
protocol ImagesCollectionViewCellDelegate: AnyObject {
    func delete(wasPressedOnCell cell: ImagesCollectionViewCell , index : Int)
    func play(wasPressedOnCell cell: ImagesCollectionViewCell)

}
class ImagesCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var vedioView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sliderImg: UIImageView!
    var playerAv: AVPlayer?
    var playerController: AVPlayerViewController?
    var playerItem: AVPlayerItem?
    var delegate: ImagesCollectionViewCellDelegate?
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
            self?.delegate?.play(wasPressedOnCell: self!)
            self?.playaction()
        }.store(self)
    }
    func setupaddpost() {
        skeleton(for: containerView)
        guard let model = model as? AddPostModel else { return }
        deleteBtn.isHidden = false
        if model.type == "backgrounds" {
            if model.url != "" {
                sliderImg.setImage(url: model.url)
            }else {
                let fullPath = model.path
                if let imageUrl = URL(string: fullPath) {
                    if let image = UIImage(contentsOfFile: imageUrl.path) {
                        sliderImg.image = image
                            } else {
                                print("Failed to load image from path: \(imageUrl.path)")
                            }
                       } else {
                           print("Invalid file path URI")
                       }
               
                
            }
            vedioView.isHidden = true
            playBtn.isHidden = true
            sliderImg.isHidden = false
        }else {
            if model.url != "" {
                guard let url = URL(string: model.url) else { return }
                playerItem = .init(url: url)
            }else {
                playerItem = .init(url: model.uri!)

            }
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
            self?.delegate?.play(wasPressedOnCell: self!)
           // self?.playaction()
        }.store(self)
        deleteBtn.publisher.listen { [weak self] in
            self?.delegate?.delete(wasPressedOnCell: self!, index: self?.indexPath() ?? 0)
        }.store(self)
    }
    func loadImage(from path: String) -> UIImage? {
            return UIImage(contentsOfFile: path)
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
    func stopPlayer() {
            if let player = playerAv {
                player.pause()
            }
        }
    func getVideoFromPath(_ path: String) -> URL? {
        let fileManager = FileManager.default
        
        // Check if the video file exists at the given path
        if fileManager.fileExists(atPath: path) {
            let videoURL = URL(fileURLWithPath: path)
            print("Video file exists at path: \(videoURL)")
            return videoURL
        } else {
            print("Video file does not exist at path: \(path)")
        }
        return nil
    }
    func showImageFromPath(imageView: UIImageView, filePath: String) {
        // Check if the file exists at the given path
        if FileManager.default.fileExists(atPath: filePath) {
            // Load the image using the file path
            if let image = UIImage(contentsOfFile: filePath) {
                // Set the image in the UIImageView
                imageView.image = image
                print("Image successfully loaded and displayed.")
            } else {
                print("Failed to create UIImage from the file path.")
            }
        } else {
            print("File does not exist at path: \(filePath)")
        }
    }
}
