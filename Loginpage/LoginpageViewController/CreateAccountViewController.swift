//
//  CreateAccountViewController.swift
//  Loginpage
//
//  Created by IE13 on 02/11/23.
//

import UIKit
import FirebaseAuth
import IQDropDownTextFieldSwift

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet weak var locationTextFiled: IQDropDownTextField!
    @IBOutlet private var showHidePasswordButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    var isShow: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        confirmPasswordTextField.layer.cornerRadius = 20
        confirmPasswordTextField.layer.masksToBounds = true
        locationTextFiled.layer.cornerRadius = 20
        locationTextFiled.layer.masksToBounds = true
        signupButton.layer.cornerRadius = 20
        signupButton.layer.masksToBounds = true
        let paddingViewName = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: nameTextField.frame.height))
        nameTextField.leftView = paddingViewName
        nameTextField.leftViewMode = .always
        let paddingViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = paddingViewEmail
        emailTextField.leftViewMode = .always
        let paddingViewPassword = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingViewPassword
        passwordTextField.leftViewMode = .always
        let paddingViewConfirmPassword = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: confirmPasswordTextField.frame.height))
        confirmPasswordTextField.leftView = paddingViewConfirmPassword
        confirmPasswordTextField.leftViewMode = .always
        
        locationTextFiled.isOptionalDropDown = false
        locationTextFiled.itemList = ["indore", "Bhopal", "banglour"]
        locationTextFiled.placeholder = "Select Location"
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        if(nameTextField.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Please enter your name.")
            return
        } else if (emailTextField.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Please enter your email.")
            return
        } else if (passwordTextField.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Please enter your password.")
            return
        } else if (confirmPasswordTextField.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Please enter confirm password.")
            return
        } else if !isValidEmail(emailTextField.text ?? "") {
            presentAlert(title: "Invalid Email", message: "Please enter correct email.")
            return
        } else if !passwordValidate(password: passwordTextField.text ?? "") {
            presentAlert(title: "Invalid Password", message: "Please enter correct password.")
            return
        } else if passwordTextField.text != confirmPasswordTextField.text {
            presentAlert(title: "Alert", message: "Your password and confirmation password do not match.")
            return
        } else if isValidEmail(emailTextField.text ?? "") &&
                    passwordValidate(password: passwordTextField.text ?? "") &&
                    passwordTextField.text == confirmPasswordTextField.text {
            guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                print("missing field data")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                if let error = error {
                    print("Account creation failed: \(error.localizedDescription)")
                    return
                }
                print("User account created successfully")
                strongSelf.presentAlert(title: "Alert" ,message: "User account created successfully")
            }
            if let loginViewController =
                storyboard?.instantiateViewController(withIdentifier: "NameViewController") as? NumberViewController {
                navigationController?.pushViewController(loginViewController, animated: true)
//                nameTextField.text = ""
//                emailTextField.text = ""
//                passwordTextField.text = ""
//                confirmPasswordTextField.text = ""
            }
        }
    }
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
        self.present(alertController, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func passwordValidate(password: String) -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: password)
    }
    @IBAction func showHidePasswordAction(_ sender: UIButton) {
        if isShow {
            let image2 = UIImage(systemName: "eye")
            showHidePasswordButton.setImage(image2, for: .normal)
            isShow = false
        } else {
            let image2 = UIImage(systemName: "eye.slash")
            showHidePasswordButton.setImage(image2, for: .normal)
            isShow = true
        }
        passwordTextField.isSecureTextEntry = isShow
    }
//    @IBAction func loginButtonAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    @IBAction func signBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        if let navigationController = navigationController {
            if navigationController.viewControllers.contains(loginViewController) {
                navigationController.popToViewController(loginViewController, animated: true)
            } else {
                navigationController.pushViewController(loginViewController, animated: true)
            }
        } else {
            present(loginViewController, animated: true, completion: nil)
        }
    }
}
