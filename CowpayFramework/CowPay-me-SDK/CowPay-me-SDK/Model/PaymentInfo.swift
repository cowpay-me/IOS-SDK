//
//  PaymentInfo.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation

public struct PaymentInfo {
    public var merchantReferenceId : String
    public var customerMerchantProfileId : String
    public var amount : String
    public var description : String
    public var customerName : String
    public var customerEmail : String
    public var customerMobile : String
    
    public init(merchantReferenceId : String,customerMerchantProfileId : String,amount : String, description : String, customerName : String,customerEmail : String,customerMobile : String) {
        self.merchantReferenceId = merchantReferenceId
        self.customerMerchantProfileId = customerMerchantProfileId
        self.amount = amount
        self.description = description
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.customerMobile = customerMobile
    }
}
