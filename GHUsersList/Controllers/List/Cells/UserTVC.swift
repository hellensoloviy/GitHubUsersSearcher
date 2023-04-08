//
//  UserTVC.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

class UserTVC: UITableViewCell {
 
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoriesCountLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    // MARK: -
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func bindModel(_ model: GHUserModel) {
        userNameLabel.text = model.name
        
    }
}

