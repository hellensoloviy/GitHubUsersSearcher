//
//  ProfileHeaderView.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation
import UIKit
import Combine

class ProfileHeaderView: UIView {
    enum Constants {
        static let followers = "Followers"
        static let following = "Following"
        
        static let defaultBio = "No Bio to show"
        static let unknownDate = "Unknown Date"
    }
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var joinedDate: UILabel!
    @IBOutlet weak var follwersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    private var model: DetailedUserModel? = nil
    private var cancellable: AnyCancellable? = nil
    
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
            self.followingCount.text = "\(Constants.following) \(count)"
        } else {
            self.followingCount.text = "\(Constants.following) 0"
        }
        
        if let count = model.followers {
            self.follwersCount.text = "\(count) \(Constants.followers)"
        } else {
            self.follwersCount.text = "0 \(Constants.followers)"
        }
        
        if let dateString = model.joinedDate, let date = CustomDateFormatter().stringToDate(dateString) {
            self.joinedDate.text = date
        } else {
            self.joinedDate.text = Constants.unknownDate
        }
        
        self.bio.text = model.about ?? Constants.defaultBio
        
        if let string = model.avatarURL, let url = URL(string: string)  {
            self.cancellable = URLSession.shared
                .downloadTaskPublisher(for: url)
                .map { UIImage(contentsOfFile: $0.url.path)! }
                .receive(on: DispatchQueue.main)
                .replaceError(with: UIImage(named: "github-mark-white")) // white so we see when not loaded
                .assign(to: \.image, on: self.avatar)
        }
        
    }
    
}
