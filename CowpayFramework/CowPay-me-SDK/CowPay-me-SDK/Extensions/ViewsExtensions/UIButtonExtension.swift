//
//  UIButtonExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

@IBDesignable
extension UIButton {
    @IBInspectable var localizationKey: String {
        set {
            setTitle(newValue.localized(), for: .normal)
        }
        get {
            return (titleLabel?.text)!
        }
    }
    
    @IBInspectable var flipRightToLeft: Bool {
        set {
            if LocalizationHelper.isArabic() == true && newValue == true {
                let rotatedImage = image(for: .normal)?.flippedImageToRight()
                setImage(rotatedImage, for: .normal)
            }
        }
        get {
            return self.flipRightToLeft
        }
    }
}
