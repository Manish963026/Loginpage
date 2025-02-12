//
//  ViewController.swift
//  Loginpage
//
//  Created by IE13 on 15/11/23.
//

import UIKit

struct SettingData {
    var section: String
    var list: [String]
}

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var settingData = [SettingData(section: "Users", list: ["Manish Prajapat"]),
                       SettingData(section: "Privacy and Terms", list: ["Privacy Policy", "Terms"]),
                       SettingData(section: "Help and Information", list: ["About", "Help Center"]),
                       SettingData(section: "Account", list: ["Logout"])
    ]
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let table = settingData[section]
        return table.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell",
                                                     for: indexPath) as? UserTableViewCell
            let setting = settingData[indexPath.section]
            cell?.userLabel.text = setting.list[indexPath.row]
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell",
                                                     for: indexPath) as? ProfileTableViewCell
            let setting = settingData[indexPath.section]
            cell?.profileNameLabel.text = setting.list[indexPath.row]
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let setting = settingData[section]
        return setting.section
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 0 && indexPath.row == 0 {
            if let privacyPolicyViewController = storyboard?.instantiateViewController(withIdentifier:
                                            "ProfileScreenViewController") as? ProfileScreenViewController {
                let navController = UINavigationController(rootViewController: privacyPolicyViewController)
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissProfile))
                privacyPolicyViewController.navigationItem.leftBarButtonItem = backButton
                self.present(navController, animated: true, completion: nil)
            }
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            if let privacyPolicyViewController = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as? PrivacyPolicyViewController {
                let navController = UINavigationController(rootViewController: privacyPolicyViewController)
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissProfile))
                privacyPolicyViewController.navigationItem.leftBarButtonItem = backButton
                self.present(navController, animated: true, completion: nil)
            }
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            if let privacyPolicyViewController = storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as? PrivacyPolicyViewController {
                let navController = UINavigationController(rootViewController: privacyPolicyViewController)
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action:
                                                    #selector(dismissProfile))
                privacyPolicyViewController.navigationItem.leftBarButtonItem = backButton
                self.present(navController, animated: true, completion: nil)
            }
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            if let privacyPolicyViewController = storyboard?.instantiateViewController(withIdentifier:
                                                "AboutViewController") as? AboutViewController {
                let navController = UINavigationController(rootViewController: privacyPolicyViewController)
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissProfile))
                privacyPolicyViewController.navigationItem.leftBarButtonItem = backButton
                self.present(navController, animated: true, completion: nil)
            }
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            if let privacyPolicyViewController = storyboard?.instantiateViewController(withIdentifier:
                                    "HelpCenterViewController") as? HelpCenterViewController {
                let navController = UINavigationController(rootViewController: privacyPolicyViewController)
                let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissProfile))
                privacyPolicyViewController.navigationItem.leftBarButtonItem = backButton
                self.present(navController, animated: true, completion: nil)
            }
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            showLogoutAlert()
        }
        func showLogoutAlert() {
            let alert = UIAlertController(title: "Logout",
                                          message: "Are you sure you want to logout?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Logout", style: .default) { [weak self] _ in

                self?.navigateToLoginPage()
            }
            yesAction.setValue(UIColor.red, forKey: "titleTextColor")
            let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    @objc func dismissProfile() {
        dismiss(animated: true, completion: nil)
    }

    func navigateToLoginPage() {
       pushViewController(withIdentifier: "LoginViewController")
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
