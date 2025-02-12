//
//  UserdetailTableViewCell.swift
//  Loginpage
//
//  Created by IE13 on 29/11/23.
//

import UIKit
import IQListKit

class UserDetailTableViewCell: UITableViewCell,IQModelableCell {
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    typealias Model = UserDetailsClass
    var model: UserDetailsClass? {
            didSet {
                guard let model = model else {
                    return
                }
                userDetailsLabel.text = model.title
                userTitleLabel.text = model.body
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
