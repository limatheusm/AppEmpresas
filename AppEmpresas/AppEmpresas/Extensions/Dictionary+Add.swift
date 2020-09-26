//
//  Dictionary+Add.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    mutating func add(value: Any?, forKey: String) {
        if let value = value {
            self.updateValue(value, forKey: forKey)
        }
    }
}
