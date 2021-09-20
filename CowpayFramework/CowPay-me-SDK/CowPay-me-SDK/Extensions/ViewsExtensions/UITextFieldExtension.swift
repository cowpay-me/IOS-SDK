//
//  UITextFieldExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable
    var isLocalized: Bool {
        get {
            return false
        } set {
            if newValue == true {
                if LocalizationHelper.isArabic() {
                    textAlignment = .right
                    makeTextWritingDirectionRightToLeft(self)
                    contentHorizontalAlignment = .right
                } else {
                    textAlignment = .left
                    makeTextWritingDirectionLeftToRight(self)
                    contentHorizontalAlignment = .left
                }
            }
        }
    }

    @IBInspectable var localizationKey: String {
        set {
            placeholder = newValue.localized()
        }
        get {
            return placeholder!
        }
    }

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    func validateText() -> Bool {
        if let text = text, text.isEmpty == false, text != "" {
            return true
        } else {
            return false
        }
    }
}
