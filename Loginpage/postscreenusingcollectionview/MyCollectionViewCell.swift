//
//  MyCollectionViewCell.swift
//  Loginpage
//
//  Created by IE13 on 18/01/24.
//

import UIKit

class HorizantleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
            myImage.layer.cornerRadius = 50
            myImage.layer.masksToBounds = true
        }
}
