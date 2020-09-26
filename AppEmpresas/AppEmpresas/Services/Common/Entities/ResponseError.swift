//
//  ResponseError.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

struct ResponseError: Codable {
    let errors: [String]?
}
