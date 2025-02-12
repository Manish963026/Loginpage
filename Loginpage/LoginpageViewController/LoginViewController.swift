//
//  LoginViewController.swift
//  Loginpage
//
//  Created by IE13 on 03/11/23.
//

import UIKit
import LocalAuthentication
import KeychainSwift
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var showHideIconChangePasswordButton: UIButton!
    @IBOutlet private var visibleButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    var isShow: Bool = true
    var isVisible: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        navigationItem.hidesBackButton = true
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        let paddingViewEmail = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = paddingViewEmail
        emailTextField.leftViewMode = .always
        let paddingViewPassword = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingViewPassword
        passwordTextField.leftViewMode = .always
    }
    @IBAction func continueButton(_ sender: UIButton) {
        if (emailTextField.text ?? "").isEmpty && (passwordTextField.text ?? "").isEmpty {
            presentAlert(title: "Alert", message: "Your enter email and password")
            return
        }
        if (emailTextField.text ?? "").isEmpty {
            presentAlert(title: "Invalid Email", message: "Your email is empty.")
            return
        }
        if !isValidEmail(emailTextField.text ?? "") {
            presentAlert(title: "Invalid Email", message: "Please enter correct email")
            return
        }
        if (passwordTextField.text ?? "").isEmpty {
            presentAlert(title: "Invalid Password", message: "Your password is empty")
            return
        }
        if !passwordValidate(password: passwordTextField.text ?? "") {
            presentAlert(title: "Invalid Password", message: "Please enter correct password.")
        }
//        if isValidEmail(emailTextField.text ?? "" ) && passwordValidate(password: passwordTextField.text ?? ""){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
//                let navigationController = UINavigationController(rootViewController: tabBarController)
//                navigationController.modalPresentationStyle = .fullScreen
//                present(navigationController, animated: true, completion: nil)
//        }
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("missing field data")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            if let error = error as NSError? {
                print("Login failed: \(error.localizedDescription)")
                strongSelf.showAlert(message: "create account then login")
                if error.code == AuthErrorCode.wrongPassword.rawValue || error.code == AuthErrorCode.invalidEmail.rawValue {
                    //strongSelf.showCreateAccount(email: email, password: password)
                } else {
                    strongSelf.showAlert(message: "Login failed. Please try again.")
                }
                return
            }
           // strongSelf.showAlert(message: "Login successful!")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                            let navigationController = UINavigationController(rootViewController: tabBarController)
                            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }
        setDetails()
    }
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
        self.present(alertController, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
//        let image2 = UIImage(systemName: "eye.fill")
//        sender.setImage(image2, for: .normal)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    @IBAction func showHidePasswordAction(_ sender: UIButton) {
        if isShow {
            let image2 = UIImage(systemName: "eye")
            showHideIconChangePasswordButton.setImage(image2, for: .normal)
            isShow = false
        } else {
            let image2 = UIImage(systemName: "eye.slash")
            showHideIconChangePasswordButton.setImage(image2, for: .normal)
            isShow = true
        }
        passwordTextField.isSecureTextEntry = isShow
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
    @IBAction func checkedButtonAction(_ sender: UIButton) {
        if isVisible {
            let image2 = UIImage(named: "uncheckbox")
            visibleButton.setImage(image2, for: .normal)
        } else {
            let image2 = UIImage(named: "checked")
            visibleButton.setImage(image2, for: .normal)
        }
        isVisible = !isVisible
    }
    func setDetails() {
        UserDefaults.standard.set(isVisible, forKey: "checkbox")
//        KeychainWrapper.standard.set(emailTextField.text!, forKey: "Email")
//        KeychainWrapper.standard.set(passwordTextField.text!, forKey: "Password")
//        Keychain.save(emailTextField.text!, forKey: "Email")
//        Keychain.save(passwordTextField.text!, forKey: "Password")
        let keychain = KeychainSwift()
        keychain.set(emailTextField.text!, forKey: "Email")
        if let email = emailTextField.text {
            UserDefaults.standard.set(email, forKey: "email")

        }
        keychain.set(passwordTextField.text!, forKey: "Password")
    }
    @IBAction func authenticationButtonAction(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason) {[ weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        let visible = UserDefaults.standard.bool(forKey: "checkbox")
                        let keychain = KeychainSwift()
                        let email = keychain.get("Email")
                        let password = keychain.get("Password")
                        if visible {
                            self?.isVisible = true
                            self?.emailTextField.text = email
                            self?.passwordTextField.text = password
                            let image2 = UIImage(named: "checked")
                            self?.visibleButton.setImage(image2, for: .normal)
                        }
                    } else {
                        let alertController = UIAlertController(title: "Authentification field",
                        message: "You could not be verified; please try again", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
                        self?.present(alertController, animated: true)
                        return
                    }
                }
            }
        } else {
            let alertController = UIAlertController(title: "Biometry unavilable", message:
                                                        ConstantHandle.biometricMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in}))
            self.present(alertController, animated: true)
            return
        }
    }
}
