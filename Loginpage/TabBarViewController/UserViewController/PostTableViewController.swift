//
//  PostTableViewController.swift
//  Loginpage
//
//  Created by IE13 on 28/11/23.
//

import UIKit
import IQPullToRefresh
import IQAPIClient
class PostTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var postList: [PostClass] = []
    
    @IBOutlet weak var tableView: UITableView!
    lazy var refresher = IQPullToRefresh(scrollView: tableView, refresher: self, moreLoader: self)
    var userId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refresher.refresh()
        refresher.enablePullToRefresh = true
        refresher.enableLoadMore = false
        fetchData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell",
                                                       for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.namedLabel.text = postList[indexPath.row].name
        cell.usernameLabel.text = postList[indexPath.row].username
        cell.emailLabel.text = postList[indexPath.row].email
        return cell
    }
    func fetchData() {
        Task {
            do {let users = try await IQAPIClient.default.userDetails()
                print(users)
                postList = users
                tableView.reloadData()
            } catch{
                print("error")
            }
        }
        //        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
        //                    return
        //                }
        //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //                    if let error = error {
        //                        print("Error occurred: \(error)")
        //                        return
        //                    }
        //                    guard let data = data else {
        //                        print("Data is nil")
        //                        return
        //                    }
        //                    do {
        //                        let receivedData = try JSONDecoder().decode([PostClass].self, from: data)
        //                        self.postList = receivedData
        //                        print("Data loaded successfully")
        //                        DispatchQueue.main.async {
        //                            self.tableView.reloadData()
        //                        }
        //                    } catch {
        //                        print("Error occurred in Decoding: \(error)")
        //                    }
        //                }
        //                task.resume()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:
                                                                    "UserDetailViewController") as? UserDetailViewController {
            controller.userId = postList[indexPath.section].id
            navigationController?.pushViewController(controller, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
extension PostTableViewController: MoreLoadable, Refreshable {
    func refreshTriggered(type: IQPullToRefresh.RefreshType, loadingBegin: @escaping (Bool) -> Void, loadingFinished: @escaping (Bool) -> Void) {
        loadingBegin(true)
        fetchData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.tableView.reloadData()
            loadingFinished(true)
        }
    }
    func loadMoreTriggered(type: IQPullToRefresh.LoadMoreType, loadingBegin: @escaping (Bool) -> Void, loadingFinished: @escaping (Bool) -> Void) {
        loadingFinished(true)
    }
}
extension IQAPIClient {
    func userDetails() async throws ->  [PostClass]{
        return  try await sendRequest(path: "/users").result
    }
}
