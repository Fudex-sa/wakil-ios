//
//  ShowfatoaraVC.swift
//  Raha
//
//  Created by mahmoud ezzat on 20/10/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import WebKit

// MARK: - ...  ViewController - Vars
class ShowfatoaraVC: BaseController {
    @IBOutlet weak var fatoraWeb: WKWebView!
    @IBOutlet weak var downloadBtn: UIButton!
    var viewModel: ShowfatoaraViewModel?
    var coordinator: ShowfatoaraCoordinator?
    var url = ""
    var downlaodurl = ""
}

// MARK: - ...  LifeCycle
extension ShowfatoaraVC {
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
    }
}
// MARK: - ...  Functions
extension ShowfatoaraVC {
    func setup() {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            fatoraWeb.load(request)
        }
        downloadBtn.publisher.listen(on: {[weak self] _ in
            self?.downloadFile(from: self?.downlaodurl ?? "")
        }).store(self)
        
    }
    func downloadFile(from url1: String) {
        guard let url = URL(string: url1) else { return }
               
               URLSession.shared.downloadTask(with: url) { localURL, _, error in
                   guard let localURL = localURL else {
                       print("❌ Download failed:", error?.localizedDescription ?? "Unknown error")
                       return
                   }
                   
                   // ✅ Rename file to .pdf before sharing
                   let fileManager = FileManager.default
                   let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                   let pdfDestination = docs.appendingPathComponent("invoice.pdf")
                   
                   // Remove old file if exists
                   try? fileManager.removeItem(at: pdfDestination)
                   
                   do {
                       try fileManager.moveItem(at: localURL, to: pdfDestination)
                       print("✅ PDF saved to:", pdfDestination)
                       
                       DispatchQueue.main.async {
                           let activityVC = UIActivityViewController(activityItems: [pdfDestination], applicationActivities: nil)
                           activityVC.popoverPresentationController?.sourceView = self.view
                           self.present(activityVC, animated: true)
                       }
                   } catch {
                       print("❌ Move error:", error.localizedDescription)
                   }
               }.resume()
    }
}
// MARK: - ...  View Contract
extension ShowfatoaraVC {
}
extension ShowfatoaraVC: URLSessionDownloadDelegate {
func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    guard let _ = try? Data(contentsOf: location) else {
        print("The data could not be loaded")
//        SpinnerAction.shared.hideActivityIndicator()
//        ToastManager.shared.showError(message: "Corrupted file".localized(), view: self.view, status: .failure)
        return
    }
    print("File Downloaded Location- ",  location)
          
    let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filename = downloadTask.originalRequest?.url?.lastPathComponent ?? "invoice.pdf"
            let destination = docs.appendingPathComponent(filename)
            
            // Remove old file if exists
            try? FileManager.default.removeItem(at: destination)
            
            // Move file to Documents
            do {
                try FileManager.default.copyItem(at: location, to: destination)
                print("✅ File moved to:", destination.path)
               // downloadedFileURL = destination
            } catch {
                print("❌ Copy error:", error.localizedDescription)
                return
            }

        DispatchQueue.main.async { [weak self] in
        guard let self = self else {return}
        //            self?.downloadImageView.image = image
        //            self?.progressLbl.isHidden = true
       
            NotificationBuilder().setTitle("Success".localized)
                                   .setBody("File downloaded successfully".localized)
                                   .setTheme(.success)
                                   .bulid()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presentShareSheet(for: destination)
            }
           
            
        }
}

func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//    let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    
    //        DispatchQueue.main.async { [weak self] in
    //            self?.progressBar.progress = progress
    //            self?.progressLbl.text = "\(progress * 100)%"
    
    
}
    func presentShareSheet(for fileURL: URL) {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            present(activityVC, animated: true)
        }
}
