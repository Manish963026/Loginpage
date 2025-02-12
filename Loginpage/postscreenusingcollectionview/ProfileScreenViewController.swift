import UIKit

class ProfileScreenViewController: UIViewController {
    @IBOutlet weak var containerView: UICollectionView!
    @IBOutlet weak var profileImage: UIImageView!
    let group1Images: [UIImage] = [UIImage(named: "png2")!,
        UIImage(named: "png4")!, UIImage(named: "png4")!,UIImage(named: "png4")!,UIImage(named: "png6")!,
        UIImage(named: "png6")!, UIImage(named: "png6")!]
    let group2Images: [UIImage] = [UIImage(named: "png6")!, UIImage(named: "png2")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 65
        setupCollectionView()
    }
    private func setupCollectionView() {
        containerView.delegate = self
        containerView.dataSource = self
        containerView.collectionViewLayout = createCollectionViewLayout()
    }
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.2)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item, item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(0.5)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 3, bottom: 3, trailing: 8)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item, item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 3, trailing: 5)
                return section
            }
        }
    }
    
    @IBAction func crashAction(_ sender: Any) {
        let num = [0]
        print(num[1])
    }
}

extension ProfileScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
            indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                    for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            if indexPath.item < group1Images.count {
                cell.imageView.image = group1Images[indexPath.item]
            }
        default:
            if indexPath.item < group2Images.count {
                cell.imageView.image = group2Images[indexPath.item]
            }
        }
        return cell
    }
    
    
}
