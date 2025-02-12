//
//  ViewController.swift
//  
//
//  Created by IE13 on 18/01/24.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var detailCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    private func setupCollectionView() {
            detailCollectionView.delegate = self
            detailCollectionView.dataSource = self
            detailCollectionView.collectionViewLayout = createCollectionViewLayout()
            detailCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? 1 : 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 8
        return cell
    }
}
