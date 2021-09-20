//
//  Encodable.swift
//  AlFatiha
//
//  Created by fares elsokary on 8/10/20.
//  Copyright © 2020 fares elsokary. All rights reserved.
//

import Foundation
extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}
