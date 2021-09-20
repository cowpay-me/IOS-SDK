//
//  UILabelExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable var localizationKey: String {
        set {
            text = newValue.localized()
        }
        get {
            return text!
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = textAlignment
        let attrString = NSMutableAttributedString()
        if attributedText != nil {
            attrString.append(attributedText!)
        } else {
            attrString.append(NSMutableAttributedString(string: text ?? ""))
            attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        attributedText = attrString
    }
}
