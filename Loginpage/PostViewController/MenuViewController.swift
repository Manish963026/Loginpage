//
//  ViewController.swift
//  Loginpage
//
//  Created by IE13 on 21/11/23.
//

import UIKit
import SideMenu
class MenuViewController: UIViewController {

    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
}
class MenuListController: UITableViewController {
    var items = ["Home", "About", "Contact ", "Details", "More about"]
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Handle the selection here
            switch indexPath.row {
            case 0: // Home
                navigateToHome()
            // Add cases for other menu items if needed
            default:
                break
            }
        }

        func navigateToHome() {
            let homeViewController = SecondHomeViewController()
            if let navigationController = self.navigationController {
                navigationController.pushViewController(homeViewController, animated: true)
            }

        }
}
