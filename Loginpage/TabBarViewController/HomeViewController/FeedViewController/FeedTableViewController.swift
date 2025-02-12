
import UIKit



class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titleList: [FeedClass] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
                tableView.refreshControl = refreshControl
        fetchData()
    }
    @objc func refreshData() {
            // Perform data fetching logic here
        refreshControl.beginRefreshing()
            fetchData()

            // End refreshing
            refreshControl.endRefreshing()
        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
      cell.titleLabel.text = titleList[indexPath.row].title
      cell.detailsLabel.text = titleList[indexPath.row].body
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }

    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
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
                        let receivedData = try JSONDecoder().decode([FeedClass].self, from: data)
                        self.titleList = receivedData
                        print("Data loaded successfully")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error occurred in Decoding: \(error)")
                    }
                    
                }
        tableView.reloadData()
                task.resume()
            }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:
                                                    "UserTableViewController") as? UserInfoTableViewController {
            controller.userId = titleList[indexPath.section].id
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func postButton(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:
                                                    "PlayerViewController") as? PlayerViewController {
            present(controller, animated: true)
        }
    }
}
