//
//  DoubleExtension.swift
//  SelfService
//
//  Created by Imac on 7/10/20.
//  Copyright © 2020 IbnSinai. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places: Int = 2) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
