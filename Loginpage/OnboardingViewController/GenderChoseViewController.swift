//////
//////  ViewController.swift
//////  Loginpage
////
////  Created by IE13 on 22/11/23.
////
//
import UIKit

class GenderChoseViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    var isMaleButtonSelected = false
    @IBOutlet weak var femaleButton: UIButton!
    var isFemaleButtonSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        maleButton.layer.cornerRadius = maleButton.frame.height / 2
        femaleButton.layer.cornerRadius = femaleButton.frame.height / 2
        nextButton.layer.cornerRadius = 20
        nextButton.layer.masksToBounds = true
    }
    @IBAction func maleButtonAction(_ sender: UIButton) {
        if !isMaleButtonSelected {
            maleButton.backgroundColor = .systemCyan
                    isMaleButtonSelected = true
                  femaleButton.backgroundColor = .white
                 isFemaleButtonSelected = false
             }
         }

    @IBAction func femaleButtonAction(_ sender: Any) {
       if !isFemaleButtonSelected {
                 femaleButton.backgroundColor = .systemCyan
                   isFemaleButtonSelected = true
                   maleButton.backgroundColor = .white
                   isMaleButtonSelected = false
               }
   }
    @IBAction func nextButtonTaped(_ sender: Any) {
        if isMaleButtonSelected || isFemaleButtonSelected {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let congratulationViewController = storyboard.instantiateViewController(withIdentifier: "CongratulationViewController")
                    navigationController?.pushViewController(congratulationViewController, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Alert", message: "Please select a gender",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
            }
    }
