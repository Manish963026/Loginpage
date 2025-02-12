extension String {
    static let keyForImage = "data"
}

import UIKit
import AVFoundation
import MobileCoreServices

class PlayerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        selectedImageView.layer.cornerRadius = 80
        retrieveData(key: .keyForImage)
    }

    @IBAction func imageButtonAction(_ sender: UIButton) {
        let view = UIAlertController(title: "Select", message: "Select from?", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) {[weak self] (_) in
            self?.showImagePicker(selectedSource: .camera, sender: sender)
        }
        let libraryButton = UIAlertAction(title: "Library", style: .default) {[weak self]  (_) in
            self?.showImagePicker(selectedSource: .photoLibrary, sender: sender)
        }
        let videoLibraryButton = UIAlertAction(title: "Video Library", style: .default) {[weak self]  (_) in
            self?.showImagePicker(selectedSource: .photoLibrary, mediaTypes: [ kUTTypeMovie as String], sender: sender)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        view.addAction(cameraButton)
        view.addAction(libraryButton)
        view.addAction(videoLibraryButton)
        view.addAction(cancelButton)

        // Check if the device is iPad and adjust the presentation style
        if let popoverController = view.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }

        self.present(view, animated: true, completion: nil)
    }

    func showImagePicker(selectedSource: UIImagePickerController.SourceType, mediaTypes: [String]? = nil, sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source not available")
            return
        }

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        if let mediaTypes = mediaTypes {
            imagePickerController.mediaTypes = mediaTypes
        }
        imagePickerController.allowsEditing = false

        // Check if the device is iPad and adjust the presentation style
        if let popoverController = imagePickerController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }

        self.present(imagePickerController, animated: true, completion: nil)
    }

    func save(image: UIImage) {
        let imageData = image.pngData()! as NSData
        UserDefaults.standard.set(imageData, forKey: .keyForImage)
        print("Image saved")
    }

    func retrieveData(key: String) {
        guard let data = UserDefaults.standard.value(forKey: key) as? NSData else { return }
        let image = UIImage(data: data as Data)
        selectedImageView.image = image
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let mediaType = info[.mediaType] as? String {
            if mediaType == kUTTypeImage as String, let image = info[.originalImage] as? UIImage {
                selectedImageView.image = image
                save(image: image)
            } else if mediaType == kUTTypeMovie as String, let videoURL = info[.mediaURL] as? URL {
                let thumbnailImage = generateThumbnail(for: videoURL)
                selectedImageView.image = thumbnailImage
            }
        }
    }

    func generateThumbnail(for videoURL: URL) -> UIImage? {
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true

        do {
            let cgImage = try imageGenerator.copyCGImage(at: CMTime(seconds: 0, preferredTimescale: 1), actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("Error generating thumbnail: \(error)")
            return nil
        }
    }
    @IBAction func moveImageButton(_ sender: UIButton) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
          if let viewController = storyboard.instantiateViewController(withIdentifier:
                           "ImageViewController") as? ImageViewController {
               viewController.select = selectedImageView.image
               navigationController?.pushViewController(viewController, animated: true)
           }
       }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        let text = titleTextField.text
        let description = descriptionTextView.text
       let uiActivityViewController = UIActivityViewController(activityItems: [text ?? "", description ?? ""], applicationActivities: nil)
        if let popoverController = uiActivityViewController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .any
        }

        self.present(uiActivityViewController, animated: true, completion: nil)
    }

       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           titleTextField.resignFirstResponder()
           descriptionTextView.resignFirstResponder()
           return true
       }
   }
