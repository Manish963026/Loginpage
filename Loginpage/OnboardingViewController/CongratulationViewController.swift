//
//  CongratulationViewController.swift
//  Loginpage
//
//  Created by IE13 on 06/11/23.
//

import UIKit

class CongratulationViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        continueButton.layer.cornerRadius = 20
        continueButton.layer.masksToBounds = true
    }
    @IBAction func continueButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            let navigationController = UINavigationController(rootViewController: tabBarController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
    }
}
