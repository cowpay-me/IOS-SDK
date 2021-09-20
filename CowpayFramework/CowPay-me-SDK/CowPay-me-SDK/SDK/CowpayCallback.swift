//
//  CowpayCallback.swift
//  CowPay-me-SDK
//
//  Created by ahmed bassiouny on 9/14/21.
//

import Foundation

public protocol CowpayCallback {
    func successByFawry(fawry:Fawry?)
    func successByCard(card:Card?)
    func error()
    func successByCashCollection(cashCollection:CashCollection?)
    func closeByUser()
}
