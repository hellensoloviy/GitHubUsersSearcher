//
//  UIViewController+Alertable.swift
//  GHUsersList
//
//  Created by Hellen Soloviy on 08.04.2023.
//

import Foundation
import UIKit

protocol Alertable {
    func showError(with message: String?)
}

extension UIViewController: Alertable {
    func showError(with message: String? = nil) {
        let dialogMessage = UIAlertController(title: String(localized: "Error"),
                                              message: message ??  String(localized: "Unknown error"),
                                              preferredStyle: .alert)
        
        let close = UIAlertAction(title: String(localized: "OK"), style: .default, handler: { (action) -> Void in
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
         })
        
        dialogMessage.addAction(close)
        
        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
