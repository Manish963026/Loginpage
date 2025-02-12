//
//  forgotViewController.swift
//  Loginpage
//
//  Created by IE13 on 03/11/23.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 20
        submitButton.layer.masksToBounds = true
        let paddingViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = paddingViewEmail
        emailTextField.leftViewMode = .always
        let backButton = UIBarButtonItem()
                backButton.title = "Back" // Set the text for the back button if needed
                backButton.tintColor = UIColor.systemCyan// Set your desired color
                self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    @IBAction func emailTextFieldAction(_ sender: UIButton) {
        if !isValidEmail(emailTextField.text ?? "") {
            presentAlert(title: "Invalid Email", message: "Please enter correct email.")
            return
        }
    }
    func presentAlert(title: String, message: String) {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
           self.present(alertController, animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
