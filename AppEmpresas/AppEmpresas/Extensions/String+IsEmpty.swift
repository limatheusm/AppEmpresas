//
//  String+IsEmpty.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

extension String {
    func isEmpty(shouldTrim: Bool = true) -> Bool {
        return shouldTrim ? self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty :
            self.isEmpty
    }
}
