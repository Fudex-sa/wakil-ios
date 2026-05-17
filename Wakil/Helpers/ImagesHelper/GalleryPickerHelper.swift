//  GalleryPickerHelper
//  Created by Mohamed Abdo.

import UIKit
import MobileCoreServices
import AVFoundation
import Photos

internal final class GalleryPickerHelper: NSObject, VideoPickerDelegate {
    private var picker: UIImagePickerController?
    private weak var _delegate: GalleryPickerDelegate?
    internal var delegate: GalleryPickerDelegate? {
        set {
            _delegate = newValue
        } get {
            return _delegate
        }
    }
    weak var scene: UIViewController?
    var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)

    internal var onPickImage: ((UIImage) -> Void)?,
    onPickImageURL: ((URL?) -> Void)?,
    onPickImageData: ((Data?) -> Void)?,
    onCancel: (() -> Void)?,
    placeholderImage = UIImage(),
    alertTitle, alertMessage: String?,
    tintColor = UIColor.darkGray,
    cameraTitle = "camera.lan".localized, libraryTitle = "photo.library.lan".localized, cancelTitle = "cancel.lan".localized,
    onError: (() -> Void)?,
    onPickVideoURL: ((URL) -> Void)?

    
    internal func pick(in screen: UIViewController?, type: PickingType = .picture) {
        scene = screen
//        if !authroize(.camera, .photoLibrary) {
//            return access(.camera, .photoLibrary)
//        }
        picker = UIImagePickerController()
        picker?.delegate = self
        picker?.allowsEditing = true
        picker?.mediaTypes = [ type == .picture ? kUTTypeImage as String : kUTTypeMovie as String]
        let alert = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        alert.view.layer.cornerRadius = 4.0
        alert.view.tintColor = tintColor
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { [weak self] (_) in
            NSLog("tell user something in `onCancel` block because he cancel picking")
            self?.onCancel?()
        }))
        alert.addAction(cameraAction(in: screen))
        if #available(iOS 14, *) {
            alert.addAction(libraryAction(in: screen))
        } else {
            // Fallback on earlier versions
        }
        screen?.present(alert, animated: true)
    }
    private func cameraAction(in screen: UIViewController?) -> UIAlertAction {
        return UIAlertAction(title: cameraTitle, style: .default, handler: { [weak self] (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                   NSLog("Camera hardware not available")
                   self?.onError?()          // your custom error callback
                   return
               }

               // 2. Check & request camera permission
               let status = AVCaptureDevice.authorizationStatus(for: .video)

               switch status {
               case .authorized:
                   // Already authorized: present camera
                   self?.presentCamera(from: screen!)

               case .notDetermined:
                   // Ask for permission the first time
                   AVCaptureDevice.requestAccess(for: .video) { granted in
                       DispatchQueue.main.async {
                           if granted {
                               self?.presentCamera(from: screen!)
                           } else {
                               NSLog("User denied camera permission")
                               self?.onError?()
                           }
                       }
                   }

               case .denied, .restricted:
                   NSLog("Camera access denied or restricted")
                   self?.onError?()
                   // 👉 Optionally present an alert to guide user to Settings.

               @unknown default:
                   self?.onError?()
               }
        })
    }
    private func presentCamera(from screen: UIViewController) {
        guard let picker = self.picker else {
            NSLog("ImagePicker is nil")
            self.onError?()
            return
        }
        picker.sourceType = .camera
        screen.present(picker, animated: true)
    }
    @available(iOS 14, *)
    private func libraryAction(in screen: UIViewController?) -> UIAlertAction {
        return UIAlertAction(title: libraryTitle, style: .default, handler: { [weak self] (_) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                    NSLog("Photo library not available")
                    self?.onError?()
                    return
                }

                // 2. Check Photos permission
                let status = PHPhotoLibrary.authorizationStatus()

                switch status {
                case .authorized, .limited:
                    // ✅ Already allowed
                    self?.presentPhotoLibrary(from: screen!)

                case .notDetermined:
                    // Ask for permission the first time
                    PHPhotoLibrary.requestAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .authorized || newStatus == .limited {
                                self?.presentPhotoLibrary(from: screen!)
                            } else {
                                NSLog("User denied photo library access")
                                self?.onError?()
                            }
                        }
                    }

                case .denied, .restricted:
                    NSLog("Photo library access denied or restricted")
                    self?.onError?()
                    // 👉 Optionally show an alert guiding user to Settings.

                @unknown default:
                    self?.onError?()
                }
        })
    }
    private func presentPhotoLibrary(from screen: UIViewController) {
        guard let picker = self.picker else {
            NSLog("ImagePicker is nil")
            self.onError?()
            return
        }
        picker.sourceType = .photoLibrary
        screen.present(picker, animated: true)
    }
    internal func getThumbnailImage(for url: URL) -> UIImage? {
        let asset = AVAsset.init(url: url)
        let imageGenerator = AVAssetImageGenerator.init(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        guard let cgImage = try? imageGenerator.copyCGImage(at: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
                                                            actualTime: .none) else { return .none }
        return UIImage.init(cgImage: cgImage)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        NSLog("tell user something in `onCancel` block because he cancel picking")
        picker.dismiss(animated: true, completion: onCancel)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            onPickVideoURL?(videoURL)
            delegate?.galleryPicker(self, forURL: videoURL)
        } else {
            var pickedImage = placeholderImage
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                pickedImage = editedImage
            } else if let originalPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                pickedImage = originalPhoto
            }
            NSLog("user picking image you can find it in `onPickImage` block")
            onPickImage?(pickedImage)
            onPickImageURL?(getImageURL(image: pickedImage))
            delegate?.galleryPicker(self, forImage: pickedImage)
            delegate?.galleryPicker(self, forURL: getImageURL(image: pickedImage))
        }
        picker.dismiss(animated: true)
    }
    func getImageURL(image: UIImage) -> URL? {
        var photoURL: URL?
        let date1 = String(NSDate().timeIntervalSince1970) + ".png"
        saveImage(image: image, name: date1)
        photoURL = getSavedImage(named: date1)
        
        //photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
        
        return photoURL
    }
    func saveImage(image: UIImage, name: String? = "fileName.png") {
        guard let data = image.compressedData(quality: 0.5) as NSData? else { return }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else { return }
        do {
            try data.write(to: directory.appendingPathComponent(name ?? "")!)
        } catch {
            print(error.localizedDescription)
        }
    }
    func getSavedImage(named: String) -> URL? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named)
        }
        return nil
    }

}

extension GalleryPickerHelper: Permission {
    internal func reload() {
        if authroize(.camera, .photoLibrary) {
            pick(in: scene)
        } else {
            onError?()
        }
    }
}
