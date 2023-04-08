//
//  ProfileHeaderView.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var joinedDate: UILabel!
    @IBOutlet weak var follwersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    private var model: DetailedUserModel? = nil
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    func setupView(with model: DetailedUserModel) {
        self.username.text = model.username
        self.location.text = model.location
        self.email.text = model.email
        
        if let count = model.following {
            self.followingCount.text = "\(count)"
        } else {
            self.followingCount.text = "0"
        }
        
        if let count = model.followers {
            self.follwersCount.text = "\(count)"
        } else {
            self.follwersCount.text = "0"
        }
        
        if let dateString = model.joinedDate, let date = CustomDateFormatter().stringToDate(dateString) {
            self.joinedDate.text = date
        } else {
            self.joinedDate.text = "Unknown Date"
        }
        
        self.bio.text = model.about ?? "No Bio to show"
        
        
    }
    
}
