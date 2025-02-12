//
//  PopoverMessageViewController.swift
//  Loginpage
//
//  Created by IE13 on 05/01/24.
//

import UIKit

class PopoverMessageViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let showPopoverButton = UIButton(type: .system)
        showPopoverButton.setTitle("Show Popover", for: .normal)
        showPopoverButton.addTarget(self, action: #selector(showPopover), for: .touchUpInside)
        showPopoverButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showPopoverButton)
            NSLayoutConstraint.activate([
                showPopoverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                showPopoverButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
            ])
    }
    @objc func showPopover(_ sender: UIButton) {
        let popoverContentViewController = UIViewController()
        popoverContentViewController.view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = "Hello, this is a popover!hiojk"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        popoverContentViewController.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: popoverContentViewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: popoverContentViewController.view.centerYAnchor)
        ])

        popoverContentViewController.modalPresentationStyle = .popover
        if let popoverPresentationController = popoverContentViewController.popoverPresentationController {
            popoverPresentationController.delegate = self
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.permittedArrowDirections = .any
            present(popoverContentViewController, animated: true, completion: nil)
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
