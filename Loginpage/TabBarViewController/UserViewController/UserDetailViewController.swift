//
//  UserDetailViewController.swift
//  Loginpage
//
//  Created by IE13 on 29/11/23.
//

import UIKit
import IQListKit

class UserDetailViewController: UIViewController, IQListViewDataSource, IQListViewDelegate {
    var userDetailsList: [UserDetailsClass] = []
    @IBOutlet weak var tableView: UITableView!
    private lazy var list = IQList(listView: tableView, delegateDataSource: self)
    var userId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        print(userId)
        fetchData()
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userDetailsList.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell", for: indexPath) as? UserDetailTableViewCell else {
//            return UITableViewCell()
//        }
//      cell.userTitleLabel.text = userDetailsList[indexPath.row].title
//      cell.userDetailsLabel.text = userDetailsList[indexPath.row].body
//        return cell
//    }
    func fetchData() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else {
                    return
                }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error occurred: \(error)")
                        return
                    }
                    guard let data = data else {
                        print("Data is nil")
                        return
                    }
                    do {
                        let receivedData = try JSONDecoder().decode([UserDetailsClass].self, from: data)
                        self.userDetailsList = receivedData
                        print("Data loaded successfully")
                        DispatchQueue.main.async {
                            //self.tableView.reloadData()
                            self.refreshUI(animated: true)
                        }
                    } catch {
                        print("Error occurred in Decoding: \(error)")
                    }
                }
                task.resume()
            }
    func refreshUI(animated: Bool = true) {
            list.reloadData({ [self] builder in
                let section = IQSection(identifier: "first")
                builder.append([section])
                builder.append(UserDetailTableViewCell.self, models: userDetailsList, section: section)
            }, animatingDifferences: animated, completion: nil)
        }
  }
