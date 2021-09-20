//
//  StringExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

extension String {
    func localized() -> String {
        let frameworkBundle = Bundle(identifier: "com.Cowpay-me.CowpayFramework")

        let path = frameworkBundle?.path(forResource: LocalizationHelper.getCurrentLanguage(), ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

    var isPhoneNumber: Bool {
        if isAllDigits == true {
            let phoneRegex = "([0-9]{9})" // "^(05)([0-9]{8})"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return predicate.evaluate(with: self)
        } else {
            return false
        }
    }

    func isValidName() -> Bool {
        if hasSpecialCharacter || count > 60 || isEmpty || isAllSpaces() {
            return false
        }
        return true
    }

    func removeFirstZero() -> String {
        var newStr = self
        if newStr.count > 0, newStr.prefix(1) == "0" {
            newStr.removeFirst()
        }
        return newStr
    }

    var hasSpecialCharacter: Bool {
        let validString = CharacterSet(charactersIn: "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢0123456789")
        if rangeOfCharacter(from: validString) != nil {
            return true
        } else {
            return false
        }
    }

    var isAllDigits: Bool {
        let charcterSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let inputString = components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return self == filtered
    }

    func convertToArray() -> [String] {
        let array = components(separatedBy: ",")
        return array
    }

    init(array: [String]) {
        self = array.reduce("", { (res, obj) -> String in
            var separator = ","
            if res.isEmpty {
                separator = ""
            }
            return res + separator + obj
        })
    }

    func checkIfContainsUrl() -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        var url = ""
        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            url = String(self[range])
            print(url)
        }
        return !url.isEmpty
    }

    init(array: [Int]) {
        self = array.reduce("", { (res, obj) -> String in
            var separator = ","
            if res.isEmpty {
                separator = ""
            }
            return res + separator + "\(obj)"
        })
    }

    func isAllSpaces() -> Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count == 0
    }

    init(fromFile fileName: String, withExtension ext: String) {
        let fileUrl = Bundle.main.url(forResource: fileName, withExtension: ext)!
        do {
            self = try String(contentsOf: fileUrl, encoding: .utf8)
        } catch {
            self = ""
        }
    }

    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self == ""
    }

    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func validateText() -> Bool {
        if isEmpty == false, self != "" {
            return true
        } else {
            return false
        }
    }
    
    func isStringContainsOnlyNumbers() -> Bool {
          return self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
      }
    
     func luhnCheck() -> Bool {
        var sum = 0
        let digitStrings = self.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1
                
                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        return sum % 10 == 0
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        let style = NSMutableParagraphStyle()
        style.alignment = LocalizationHelper.isArabic() ? .right : .left
        return NSAttributedString(string: self, attributes: [.paragraphStyle: style])
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension NSAttributedString {
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension String {
    func heightOfString(usingFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.height
     }
}
