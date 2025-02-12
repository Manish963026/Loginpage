//
//  PreviewFilesViewController.swift
//  Loginpage
//
//  Created by IE13 on 05/01/24.
//

import UIKit
import QuickLook

class PreviewFilesViewController: UIViewController, QLPreviewControllerDataSource {
    var previewController: QLPreviewController!
    var fileURLs: [URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        let previewButton = UIButton(type: .system)
        previewButton.setTitle("Preview ", for: .normal)
        previewButton.addTarget(self, action: #selector(showPreview), for: .touchUpInside)
        previewButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previewButton)
        NSLayoutConstraint.activate([
            previewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        previewController = QLPreviewController()
        previewController.dataSource = self
    }
    @objc func showPreview() {
        if let pdfURL = URL(string: "https://wallpapers.com/images/featured/flower-pictures-unpxbv1q9kxyqr1d.jpg") {
            downloadPDFAndPresentPreview(pdfURL)
        }
    }
    func downloadPDFAndPresentPreview(_ url: URL) {
        let task = URLSession.shared.downloadTask(with: url) { [weak self] (tempLocalUrl, response, error) in
            if let localUrl = tempLocalUrl, error == nil {
                if let data = try? Data(contentsOf: localUrl), let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)
                    do {
                        try data.write(to: destinationURL)
                        self?.fileURLs = [destinationURL]
                        DispatchQueue.main.async {
                            self?.present(self?.previewController ?? QLPreviewController(), animated: true, completion: nil)
                        }
                    } catch {
                        print("Error writing file: \(error)")
                    }
                }
            }
        }
        task.resume()
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index] as QLPreviewItem
    }
}
