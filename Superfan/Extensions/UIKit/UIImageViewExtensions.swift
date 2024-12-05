//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit
import Kingfisher
import AVFoundation
//import KingfisherWebP
#if !os(watchOS)
// MARK: - Methods
public extension UIImageView {
    func setImage(url: String? , placeholder: UIImage? = UIImage(named: "placeholder"),_ completion: ((UIImage) -> Void)? = nil) {
        guard var string = url else { return }
        string = NetworkManager.instance.safeUrl(url: string)
        let url = URL(string: string)
        guard let finalUrl = url else { return }
        //        KingfisherManager.shared.defaultOptions += [
        //            .processor(WebPProcessor.default),
        //            .cacheSerializer(WebPSerializer.default)
        //        ]
        self.kf.setImage(with: finalUrl, placeholder: placeholder) { result in
            switch result {
            case .success(let image):
                completion?(image.image)
            case .failure:
                self.image = placeholder
                break
            }
        }
    }
    func generateThumbnail(for url: String?, _ completionHandler: (() -> Void)? = nil) {
        guard let url = url else {
            return
        }
        guard let url = URL(string: url) else { return }
        let avAsset = AVAsset(url: url)
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: avAsset)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    DispatchQueue.main.async {
                        self.image = UIImage(cgImage: image)
                        completionHandler?()
                    }
                }
            })
        }
    }

    /// SwifterSwift: Set image from a URL.
    ///
    /// - Parameters:
    ///   - url: URL of image.
    ///   - contentMode: imageView content mode (default is .scaleAspectFit).
    ///   - placeHolder: optional placeholder image
    ///   - completionHandler: optional completion handler to run when download finishs (default is nil).
    func download(from url: URL, contentMode: UIView.ContentMode = .scaleAspectFit,
                  placeholder: UIImage? = nil, completionHandler: ((UIImage?) -> Void)? = nil) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler?(image)
            }
        }.resume()
    }
    /// SwifterSwift: Make image view blurry
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    /// SwifterSwift: Blurred version of an image view
    ///
    /// - Parameter style: UIBlurEffectStyle (default is .light).
    /// - Returns: blurred version of self.
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}
#endif
extension UIView {
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
