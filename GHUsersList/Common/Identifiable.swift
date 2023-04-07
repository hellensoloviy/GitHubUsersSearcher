//
//  Identifiable.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 07.04.2023.
//

import UIKit

// TODO: --- a better method
protocol Identifiable {
    var identifier: String { get }
}

extension UITableViewCell: Identifiable {
    var identifier: String { String(describing: self) }
}

