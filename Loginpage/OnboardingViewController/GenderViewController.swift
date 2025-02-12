//
//  GenderViewController.swift
//  Loginpage
//
//  Created by IE13 on 06/11/23.
//

import UIKit

class GenderViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        continueButton.layer.cornerRadius = 20
        continueButton.layer.masksToBounds = true
    }
    @IBAction func genderActionButton(_ sender: UIButton) {
     pushViewController(withIdentifier: "CongratulationViewController")
    }
    func pushViewController(withIdentifier identifier: String) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: identifier) {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
