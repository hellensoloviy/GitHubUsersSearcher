//
//  RepositoryDetailsTVC.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

class RepositoryDetailsTVC: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!

    // MARK: -
    override func prepareForReuse() {
        super.prepareForReuse()
        forksCountLabel.text = "0"
        starsCountLabel.text = "0"
        nameLabel.text = "0"
    }
    
    func bindRepositoryModel(_ model: RepositoryModel) {
        self.forksCountLabel.text = "\(model.forksCount)"
        self.starsCountLabel.text = "\(model.starsCount)"
        self.nameLabel.text = model.name
    }
}
