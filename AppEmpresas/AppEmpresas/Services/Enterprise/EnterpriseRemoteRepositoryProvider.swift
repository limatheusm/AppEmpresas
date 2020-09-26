//
//  EnterpriseRemoteRepositoryProvider.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

class EnterpriseRemoteRepositoryProvider: EnterpriseRepositoryProvider {
    private let api: EnterpriseAPIProtocol
    
    init(api: EnterpriseAPIProtocol = EnterpriseAPIManager()) {
        self.api = api
    }
    
    // MARK: - EnterpriseRepositoryProvider
    
    func fetchEnterprises(name: String?, type: Int?, completion: @escaping (Result<[Enterprise], Error>) -> Void) {
        self.api.list(name: name, type: type, completion: completion)
    }
    
    func fetchEnterprise(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void) {
        self.api.show(id: id, completion: completion)
    }
}
