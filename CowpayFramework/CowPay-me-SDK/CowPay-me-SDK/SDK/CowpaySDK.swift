//
//  CowpaySDK.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation
 public class CowpaySDK {
    
    public static var token = ""
    public static var merchantCode = ""
    public static var haskey = ""
    public static var enviroment = Enviroment.staging
    public static var paymentMethodAvailability = [CowpaySDKPaymentMethod.CARD,CowpaySDKPaymentMethod.FAWRY,CowpaySDKPaymentMethod.CASH_COLLECTION]
    
    public static var paymentInfo : PaymentInfo?
    internal static var callback : CowpayCallback?
    public static func getUrl() -> String {
        
        if(enviroment == Enviroment.live){
        return "https://cowpay.me/api/v2/"
        }
        else {
        return "https://staging.cowpay.me/api/v2/"
        }
    }
    
    public static func getUrlForm() -> String {
        if(enviroment == Enviroment.live){
        return "https://cowpay.me/v2/card/form/"
        }
        else { return "https://staging.cowpay.me/v2/card/form/"}
    }
    
}


public enum Enviroment {
    case staging
    case live
}


public enum Language {
    case en
    case ar
}


public enum CowpaySDKPaymentMethod{
    case CARD
    case FAWRY
    case CASH_COLLECTION
}
