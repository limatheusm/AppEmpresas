//
//  Enterprise.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

struct EnterprisesResponse: Codable {
    let enterprises: [Enterprise]?
}

struct EnterpriseResponse: Codable {
    let enterprise: Enterprise?
    let success: Bool?
}

struct Enterprise: Codable {
    let id: Int?
    let name, description: String?
    let email, facebook, twitter, linkedin, phone: String?
    let ownEnterprise: Bool?
    let photo: String?
    let value, shares, ownShares: Int?
    let sharePrice: Double?
    let city, country: String?
    let enterpriseType: EnterpriseType?
    
    var thumbnailURL: URL? {
        return URL(string: "https://empresas.ioasys.com.br/\(self.photo ?? "")")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, description, facebook, twitter, linkedin, phone, photo, value, shares, city, country
        case name = "enterprise_name"
        case email = "email_enterprise"
        case ownEnterprise = "own_enterprise"
        case sharePrice = "share_price"
        case ownShares = "own_shares"
        case enterpriseType = "enterprise_type"
    }
}

struct EnterpriseType: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "enterprise_type_name"
    }
}
