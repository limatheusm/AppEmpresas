//
//  AuthCredentials.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

struct AuthCredentials: Codable {
    let accessToken: String
    let client: String
    let uid: String
}
