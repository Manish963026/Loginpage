//
//  ProfileViewController.swift
//  Loginpage
//
//  Created by IE13 on 15/11/23.
//
import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var name: String! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // nameLabel.text = name
        image.layer.cornerRadius = 87.5
    }

    @IBAction func selectedImageButton(_ sender: UIButton) {
        let view = UIAlertController(title: "Select Image", message: "Select image from?", preferredStyle: .actionSheet)

        let cameraButton = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(selectedSource: .camera, sender: sender)
        }
        let libraryButton = UIAlertAction(title: "Library", style: .default) { [weak self]  (_) in
            self?.showImagePicker(selectedSource: .photoLibrary, sender: sender)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        view.addAction(cameraButton)
        view.addAction(libraryButton)
        view.addAction(cancelButton)
        if let popoverController = view.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        self.present(view, animated: true, completion: nil)
    }

    func showImagePicker(selectedSource: UIImagePickerController.SourceType, sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source not available")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false

        if let popoverController = imagePickerController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            image.image = selectedImage
        } else {
            print("Image not found")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
