//
//  CreditCardValidator.swift
//  TheChefzCustomer
//
//  Created by Holo Technology on 7/6/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

enum CreditCardType {

    case visa
    case visaElectron
    case mastercard
    case maestro
    case americanExpress
    case dinnersClub
    case discovery
    case jcb
    case mada

    static var all: [CreditCardType] {
        return [
            .visa,
            .visaElectron,
            .mastercard,
            .maestro,
            .americanExpress,
            .dinnersClub,
            .discovery,
            .jcb,
            .mada
        ]
    }

    var pattern: String {
        switch self {
        case .visa: return "^4[0-9]{12}(?:[0-9]{3})?$"
        case .visaElectron: return "^(4026|417500|4508|4844|491(3|7))"
        case .mastercard: return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .maestro: return "^(5018|5020|5038|6304|6759|676[1-3])"
        case .americanExpress: return "^3[47][0-9]{5,}$"
        case .dinnersClub: return "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
        case .discovery: return "^6(?:011|5[0-9]{2})[0-9]{12}$"
        case .jcb: return "^(?:2131|1800|35\\d{3})\\d{11}$"
        case .mada: return "/4(0(0861|1757|7(197|395)|9201)|1(0685|7633|9593)|2(281(7|8|9)|8(331|67(1|2|3)))|3(1361|2328|4107|9954)|4(0(533|647|795)|5564|6(393|404|672))|5(5(036|708)|7865|8456)|6(2220|854(0|1|2|3))|8(301(0|1|2)|4783|609(4|5|6)|931(7|8|9))|93428)|5(0(4300|8160)|13213|2(1076|4(130|514)|9(415|741))|3(0906|1095|2013|5(825|989)|6023|7767|9931)|4(3(085|357)|9760)|5(4180|7606|8848)|8(5265|8(8(4(5|6|7|8|9)|5(0|1))|98(2|3))|9(005|206)))|6(0(4906|5141)|36120)|9682(0(1|2|3|4|5|6|7|8|9)|1(0|1))/"
        }
    }

}

extension CreditCardType {
    var name: String {
        switch self {
        
        case .visa:
            return "visa"
        case .visaElectron:
            return "visaElectron"
        case .mastercard:
            return "mastercard"
        case .maestro:
            return "maestro"
        case .americanExpress:
            return "americanExpress"
        case .dinnersClub:
            return "dinnersClub"
        case .discovery:
            return "discovery"
        case .jcb:
            return "jcb"
        case .mada:
            return "mada"
        }
    }
}


struct CreditCardTypeChecker {
    
    static func type(for value: String) -> CreditCardType? {
        for creditCardType in CreditCardType.all {
            if isValid(for: creditCardType, value: value) {
                return creditCardType
            }
        }
        return nil
    }
    
    private static func isValid(for cardType: CreditCardType, value: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: cardType.pattern,
                                                options: .caseInsensitive)
        
            return regex.matches(in: value,
                                 options: [],
                                 range: NSMakeRange(0, value.count)).count > 0
        } catch {
            return false
        }
    }
    
    static func luhnCheck(_ number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
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
