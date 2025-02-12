import UIKit

class PostViewController: UIViewController {
    var titleList: [FeedClass] = []
    var imageNames: [String] = ["sun", "png2", "png4", "png6", "sun", "png2", "png4", "png6","sun", "png2", "png4", "png6", "sun"]
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupCollectionView()
        setupRefreshControl()
    }
    private func setupCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.collectionViewLayout = createCollectionViewLayout()
    }
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        detailCollectionView.refreshControl = refreshControl
    }
    @objc private func refreshData() {
        fetchData()
    }
    private func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([FeedClass].self, from: data)
                DispatchQueue.main.async {
                    self?.titleList = posts
                    self?.detailCollectionView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    @IBAction func postAction(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier:
                                                    "PlayerViewController") as? PlayerViewController {
            present(controller, animated: true)
        }
    }
}
extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        } else if section == 1 {
            return titleList.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HorizantleCollectionViewCell else {
                return UICollectionViewCell()
            }
            if indexPath.row < imageNames.count {
                cell.myImage.image = UIImage(named: imageNames[indexPath.row])
            }
            return cell
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? VerticalCollectionViewCell else {
                return UICollectionViewCell()
            }
            if indexPath.row < titleList.count {
                cell.titleLabel.text = titleList[indexPath.row].title
                cell.detailLabel.text = titleList[indexPath.row].body
            }
            if indexPath.row < imageNames.count {
                cell.imageView.image = UIImage(named: imageNames[indexPath.row])
            }
            cell.layer.cornerRadius = 4
            return cell
        }
    }
}
extension PostViewController: UICollectionViewDelegateFlowLayout {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1/5),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(140)
                    ),
                    subitem: item,
                    count: 3
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                return section
            }else if section == 1{
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(300)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            }
            return nil
        }
    }
}
