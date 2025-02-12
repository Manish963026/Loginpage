//
//  NameViewController.swift
//  Loginpage
//
//  Created by IE13 on 06/11/23.
//

import UIKit

class NumberViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var numberTextField: UITextField!
    @IBOutlet weak var numberButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.delegate = self
        navigationItem.hidesBackButton = true
        let doneToolbar: UIToolbar =
        UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem =
        UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        numberTextField.inputAccessoryView = doneToolbar
        numberTextField.layer.cornerRadius = 20
        numberTextField.layer.masksToBounds = true
        numberButton.layer.cornerRadius = 20
        numberButton.layer.masksToBounds = true
        let paddingViewName = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: numberTextField.frame.height))
        numberTextField.leftView = paddingViewName
        numberTextField.leftViewMode = .always
    }
    @objc func doneButtonAction() {
        numberTextField.resignFirstResponder()
    }
    @IBAction func continueButtonAction(_ sender: UIButton) {
        if isValidPhone(phone: numberTextField.text ?? "") {
           pushViewController(withIdentifier: "BirthdayViewController")
        } else {
            presentAlert(title: "Alert", message: "Please enter your mobile number.")
        }
    }
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    private func presentAlert(title: String, message: String) {
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
