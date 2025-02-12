//
//  imageViewController.swift
//  Loginpage
//
//  Created by IE13 on 21/11/23.
//

import UIKit

class ImageViewController: UIViewController {
    var select: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet var rotationGesture: UIRotationGestureRecognizer!
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet var longGesture: UILongPressGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = select
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandle))
                imageView.addGestureRecognizer(longPressGesture)
                imageView.isUserInteractionEnabled = true
    }
    @IBAction func pinchHandle(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
              view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
              sender.scale = 1.0
    }
    @IBAction func tapHandle(_ sender: UITapGestureRecognizer) {
        print("Tap gesture press")
        likeButtonTapped()
    }
    @IBAction func rotationHandle(_ sender: UIRotationGestureRecognizer) {
        guard let view = sender.view else { return }
                view.transform = view.transform.rotated(by: sender.rotation)
                sender.rotation = 0
    }
    @objc func likeButtonTapped() {
            if likeLabel.textColor == .black {
                likeLabel.textColor = .white
                likeLabel.backgroundColor = .blue
            } else {
                likeLabel.textColor = .black
                likeLabel.backgroundColor = .white
            }
        }
    @IBAction func longPressHandle(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
                    showMessage("Long Press Detected!")
                }
       }
    func showMessage(_ message: String) {
            let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    @IBAction func panHandle(_ sender: UIPanGestureRecognizer) {
        guard let panView = sender.view else { return }
            let translation = sender.translation(in: view)
            panView.center = CGPoint(x: panView.center.x + translation.x, y: panView.center.y + translation.y)
            sender.setTranslation(.zero, in: view)
    }
}
