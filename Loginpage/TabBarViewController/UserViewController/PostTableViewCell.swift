//
//  PostTableViewCell.swift
//  Loginpage
//
//  Created by IE13 on 28/11/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var namedLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var model: PostClass? {
            didSet {
                guard let model = model else {
                    return
                }

                namedLabel.text = model.name
                usernameLabel.text = model.username
                emailLabel.text = model.email
            }
        }

    
}
