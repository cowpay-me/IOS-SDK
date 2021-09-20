//
//  DispatchQueue .swift
//  AlFatiha
//
//  Created by fares elsokary on 10/8/20.
//  Copyright © 2020 fares elsokary. All rights reserved.
//

import Foundation
import UIKit
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

extension UIWindow {
    func dismiss() {
        isHidden = true

        if #available(iOS 13, *) {
            windowScene = nil
        }
    }
}
