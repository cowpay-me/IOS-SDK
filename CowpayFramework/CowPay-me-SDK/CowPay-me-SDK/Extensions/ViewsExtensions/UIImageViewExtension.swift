//
//  UIImageViewExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

extension UIImageView {
    @IBInspectable var flipRightToLeft: Bool {
        set {
            if LocalizationHelper.isArabic() == true && newValue == true {
                let rotatedImage = image?.flippedImageToRight()
                image = rotatedImage
            }
        }
        get {
            return self.flipRightToLeft
        }
    }


    private func setDefaultImage() {
        image = UIImage(color: #colorLiteral(red: 0.9499999881, green: 0.9499999881, blue: 0.9499999881, alpha: 1), size: bounds.size)
    }
    
    
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
}

