//
//  UIViewController+Extension.swift
//  RealmSwift with MVVM
//
//  Created by sarath kumar on 07/10/20.
//  Copyright © 2020 sarath kumar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

