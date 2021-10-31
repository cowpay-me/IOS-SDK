//
//  Interactor.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation
import CommonCrypto

class Interactor {
    
    
    private var cityCodes = [ 0 : "EG-01",
                 1 : "EG-01",
                 2 : "EG-02",
                 3 : "EG-03",
                 4 : "EG-04",
                 5 : "EG-05",
                 6 : "EG-06",
                 7 : "EG-07",
                 8 : "EG-08",
                 9 : "EG-09",
                 10 : "EG-10",
                 11 : "EG-11",
                 12 : "EG-12",
                 13 : "EG-13",
                 14 : "EG-14",
                 15 : "EG-15",
                 16 : "EG-16",
                 17 : "EG-17",
                 18 : "EG-19",
                 19 : "EG-20",
                 20 : "EG-21",
                 21 : "EG-22"]
    
    func sendCreaditCard(cardNumber:String,cardName:String,month:String,year:String,cvv:String,completion: @escaping (String?,String?) -> Void){
        var json = getBaseJson()
        json["card_number"] = cardNumber
        json["cvv"] = cvv
        json["card_holder"] = cardName
        json["expiry_year"] = year
        json["expiry_month"] = month
     
        ServiceApi.sendCreditCard(json: json){ res , err in
            if let data = res {
                completion(data["token"] as? String ?? " ",nil)
            }
            if let msg = err {
                completion(nil,msg)
            }
        }
    }
    
    func sendCashCollection(name:String,email:String,phone:String,address:String,floor:String,district:String,apartment:String,index:Int,completion: @escaping (CashCollection?,String?) -> Void){
        var json = getBaseJson()
        json["address"] = address
        json["floor"] = floor
        json["district"] = district
        json["apartment"] = apartment
        json["city_code"] = cityCodes[index]
        json["customer_name"] = name
        json["customer_email"] = email
        json["customer_mobile"] = phone
     
        ServiceApi.sendCashCollectino(json: json){ res , err in
            if let data = res {
                completion(CashCollection(
                    paymentGatewayReferenceId: data["payment_gateway_reference_id"] as! String,
                    merchantReferenceId:  data["merchant_reference_id"] as! String,
                    cowpayReferenceId:  data["cowpay_reference_id"] as! Int
                ),nil)
            
            }
            if let msg = err {
                completion(nil,msg)
            }
        }
    }



    
    func sendFawry(completion: @escaping (Fawry?,String?) -> Void){
        
        ServiceApi.sendFawry(json:getBaseJson()){ res , err in
            if let data = res {
                completion(Fawry(
                    paymentGatewayReferenceId: data["payment_gateway_reference_id"] as! String,
                    merchantReferenceId:  data["merchant_reference_id"] as! String,
                    cowpayReferenceId:  data["cowpay_reference_id"] as! Int
                ),nil)
            
            }
            if let msg = err {
                completion(nil,msg)
            }
            
        }
       
    }
    
    
    private func getBaseJson() -> Dictionary<String, String>{
        var json = Dictionary<String, String>()
        json["merchant_reference_id"] = CowpaySDK.paymentInfo?.merchantReferenceId
        json["customer_merchant_profile_id"] = CowpaySDK.paymentInfo?.customerMerchantProfileId
        json["customer_name"] = CowpaySDK.paymentInfo?.customerName
        json["customer_email"] = CowpaySDK.paymentInfo?.customerEmail
        json["customer_mobile"] = CowpaySDK.paymentInfo?.customerMobile
        json["amount"] = CowpaySDK.paymentInfo?.amount
        json["signature"] = getSigniture()
        json["description"] = CowpaySDK.paymentInfo?.description
          return json
    }
    
    private func getSigniture() -> String {
        let merchantReferenceId = CowpaySDK.paymentInfo?.merchantReferenceId ?? " "
        let customerMerchantProfileId = CowpaySDK.paymentInfo?.customerMerchantProfileId ?? " "
        let amount = CowpaySDK.paymentInfo?.amount ?? "1.0"
        
        let signiture = CowpaySDK.merchantCode + merchantReferenceId + customerMerchantProfileId + amount + CowpaySDK.haskey
        
        let SignitureData = sha256(data: signiture.data(using: .utf8)!)
        let signitureString = SignitureData.map { String(format: "%02hhx", $0) }.joined()
        return signitureString
    }
    
    
    private func sha256(data : Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }
}
