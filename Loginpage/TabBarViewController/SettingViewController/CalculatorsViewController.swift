//
//  CalculatorsViewController.swift
//  Pods
//
//  Created by IE13 on 28/11/23.
//

import UIKit
class CalculatorsViewController: UIViewController {
    @IBOutlet weak var emiCalculatorButton: UIButton!
    @IBOutlet weak var calculatorButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emiCalculatorButton.layer.masksToBounds = true
        emiCalculatorButton.layer.cornerRadius = 20
        emiCalculatorButton.layer.masksToBounds = true
        calculatorButton.layer.masksToBounds = true
        calculatorButton.layer.cornerRadius = 20
        calculatorButton.layer.masksToBounds = true
    }
    @IBAction func moveButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       if let viewController = storyboard.instantiateViewController(withIdentifier:
                        "CalculatorViewController") as? CalculatorViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    @IBAction func moveEMICalculatorButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       if let viewController = storyboard.instantiateViewController(withIdentifier:
                        "EMICalculatorViewController") as? EMICalculatorViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
