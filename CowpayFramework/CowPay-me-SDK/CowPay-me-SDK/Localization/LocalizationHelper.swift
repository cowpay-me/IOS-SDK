//
//  LocalizationHelper.swift
//  SelfService
//
//  Created by Imac on 7/9/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import UIKit

class LocalizationHelper {
    // MARK: - variables

    class func isArabic() -> Bool {
        return getCurrentLanguage() == LanguageConstants.arabicLanguage.rawValue
    }

    class func languageId() -> String {
        return LocalizationHelper.isArabic() ? "1" : "2"
    }
}

// MARK: - set Views Semantics

extension LocalizationHelper {
    fileprivate class func setViewsSemantics() {
        if LocalizationHelper.getCurrentLanguage() == LanguageConstants.arabicLanguage.rawValue {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}

// MARK: - reset

extension LocalizationHelper {
    class func reset(_ complition: (() -> Void)? = nil , window: UIWindow) {
        resetRootWithCowPayView(window: window)
        complition?()
    }

    class func isSameAsPrefered() -> Bool {
        return Locale.current.languageCode == LocalizationHelper.getCurrentLanguage()
    }
    
    
    class func resetRootWithCowPayView(animated: Bool = true , window: UIWindow) {
        let frameworkBundle = Bundle(identifier: "com.Cowpay-me.CowpayFramework")
        let cowPayStoryBoard = UIStoryboard(name: "CowPay", bundle: frameworkBundle)
        //let cowPayStoryBoard = UIStoryboard(name: "CowPay", bundle: nil)
        let cowPayNavigation = cowPayStoryBoard.instantiateViewController(withIdentifier: "paymentView") as! UINavigationController
        self.setRoot(withController: cowPayNavigation, animated: animated, window: window)
    }
    
    class func setRoot(withController viewController: UIViewController,
                 animated: Bool = true , window: UIWindow) {
//        guard let window = window else {
//            return
//        }
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .fullScreen
            window.rootViewController?.present(viewController, animated: true, completion: nil)
        }
        if animated {
            UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

// MARK: - set Current Lang

extension LocalizationHelper {
    class func setCurrentLang(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang], forKey: LanguageConstants.appleLanguage.rawValue)
        userdef.synchronize()
        LocalizationHelper.setViewsSemantics()
    }
}

// MARK: - get Current Language

extension LocalizationHelper {
    class func getCurrentLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: LanguageConstants.appleLanguage.rawValue) as? NSArray
        let current = langArray?.firstObject as? String
        if let current = current {
            let currentWithoutLocale = String(current[..<current.index(current.startIndex, offsetBy: 2)])
            return currentWithoutLocale
        }
        return LanguageConstants.englishLanguage.rawValue
    }
}
