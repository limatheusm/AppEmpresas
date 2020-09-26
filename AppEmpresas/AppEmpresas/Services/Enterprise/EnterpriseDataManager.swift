//
//  EnterpriseDataManager.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 25/09/20.
//

import Foundation

class EnterpriseDataManager: EnterpriseRepository {    
    private let provider: EnterpriseRepositoryProvider
    
    init(provider: EnterpriseRepositoryProvider = EnterpriseRemoteRepositoryProvider()) {
        self.provider = provider
    }
    
    // MARK: - EnterpriseRepository
    
    func getEnterprises(name: String? = nil, type: Int? = nil,
                        completion: @escaping (Result<[Enterprise], Error>) -> Void) {
        self.provider.fetchEnterprises(name: name, type: type, completion: completion)
    }
    
    func getEnterprise(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void) {
        self.provider.fetchEnterprise(id: id, completion: completion)
    }
}
