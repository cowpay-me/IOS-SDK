//
//  UITableViewExtension.swift
//  AlFatiha
//
//  Created by fares elsokary on 10/22/20.
//  Copyright © 2020 fares elsokary. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 20)
        messageLabel.sizeToFit()
        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }
}
