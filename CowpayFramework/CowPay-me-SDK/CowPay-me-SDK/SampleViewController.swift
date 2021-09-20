//
//  NVCViewController.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import UIKit

class SampleViewController: UIViewController, CowpayCallback {
    
    func closeByUser() {
        
    }
    
    
    func successByCard(card: Card?) {
        
    }
    
    func error() {
       
    }
    
    func successByCashCollection(cashCollection: CashCollection?) {
        
    }
    
    
    func successByFawry(fawry: Fawry?) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // create object from CowPayInitializer
        let cowpaySDk = CowPayInitializer()
        // set madatory attributes
        // token
        let token = "token"
        // merchant code
        let merchantCode = "merchant code"
        // haskey
        let haskey = "hash key"
        // enviroment
        let enviroment = Enviroment.staging // you can select you enviroment (live or staging)
        // sdk language
        let lang = Language.en // you can set sdk language (ar or en)
        cowpaySDk.initSDK(token: token,merchantCode: merchantCode,haskey: haskey,enviroment: enviroment,with: lang)
        
        cowpaySDk.setPaymentMethodAvailability(arr:[CowpaySDKPaymentMethod.CARD])
        // create payment info object
        let paymentInfo = PaymentInfo(merchantReferenceId: getNumber(), customerMerchantProfileId: "15", amount: "1", description: "description from ios", customerName: "ahmed bassiouny", customerEmail: "customer@customer.com", customerMobile: "01234567890")
        
        // launch sdk with payment info object
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            cowpaySDk.launchSDKView(paymentInfo: paymentInfo, callback: self, window: window)
        }
      
    }
    

    func getNumber() -> String {
        return String(Int.random(in: 4545121 ... 454512146846852))
    }

}
