


import UIKit

class UserInfoTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var userList: [UserClass] = []
    @IBOutlet weak var tableView: UITableView!
    var userId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell",
                                                       for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
      cell.nameLabel.text = userList[indexPath.row].name
      cell.emailLabel.text = userList[indexPath.row].email
      cell.bodyLabel.text = userList[indexPath.row].body
        return cell
    }
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(userId)/comments") else {
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
                        let receivedData = try JSONDecoder().decode([UserClass].self, from: data)
                        self.userList = receivedData
                        print("Data loaded successfully")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error occurred in Decoding: \(error)")
                    }
                }
                task.resume()
            }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
