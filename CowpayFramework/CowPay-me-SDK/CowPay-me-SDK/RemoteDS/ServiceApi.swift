//
//  ServiceApi.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/13/21.
//

import Foundation


public class ServiceApi {
    
    static func sendCreditCard(json:Dictionary<String,String>,completion: @escaping ([String: Any]?,String?) -> Void){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request(CowpaySDK.getUrl()+"charge/card/direct", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in

            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                            print(json)
                            if(json["success"] as! Bool == true){
                                completion(json,nil)
                            }else {
                                completion(nil,json["status_description"] as? String)
                            }
                          }
                      case .failure(let err):
                        completion(nil,err.localizedDescription)
                      }


        }
    }
    
    static func sendCashCollectino(json:Dictionary<String,String>,completion: @escaping ([String: Any]?,String?) -> Void){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request("https://cowpay.me/api/v2/charge/cash-collection", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in

            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                            print(json)
                            if(json["success"] as! Bool == true){
                                completion(json,nil)
                            }else {
                                completion(nil,json["status_description"] as? String)
                            }
                          }
                      case .failure(let err):
                        completion(nil,err.localizedDescription)
                      }


        }
    }
    
    static func sendFawry(json:Dictionary<String,String>,completion: @escaping ([String: Any]?,String?) -> Void){
        let encoder = JSONParameterEncoder.prettyPrinted
        AF.request(CowpaySDK.getUrl()+"charge/fawry", method: .post, parameters: json,encoder:encoder,headers:headers()).responseJSON{  response in

            switch response.result {
                      case .success(let value):
                          if let json = value as? [String: Any] {
                            print(json)
                            if(json["success"] as! Bool == true){
                                completion(json,nil)
                            }else {
                                completion(nil,json["status_description"] as? String)
                            }
                          }
                      case .failure(let err):
                        completion(nil,err.localizedDescription)
                      }


        }
    }
    
    static func headers() -> HTTPHeaders
    {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization":"Bearer "+CowpaySDK.token
        ]
        
        return headers
    }
}


