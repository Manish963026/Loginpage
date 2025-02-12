//
//  BirthdayViewController.swift
//  Loginpage
//
//  Created by IE13 on 06/11/23.
//

import UIKit

class BirthdayViewController: UIViewController {
    @IBOutlet private var selectBirthdayLabel: UILabel!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        selectBirthdayLabel.layer.cornerRadius = 20
        selectBirthdayLabel.layer.masksToBounds = true
        datePicker.layer.cornerRadius = 20
        datePicker.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 20
        continueButton.layer.masksToBounds = true
    }
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        let strDate = dateFormatter.string(from: sender.date)
        self.selectBirthdayLabel.text = strDate
    }
    @IBAction func birthdayActionButton(_ sender: UIButton) {
        if (selectBirthdayLabel.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Please select your birthday date")
            return
        } else {
          pushViewController(withIdentifier: "GenderChoseViewController")
        }
    }
    func presentAlert(title: String, message: String) {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
       self.present(alertController, animated: true)
   }
    func pushViewController(withIdentifier identifier: String) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: identifier) {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
