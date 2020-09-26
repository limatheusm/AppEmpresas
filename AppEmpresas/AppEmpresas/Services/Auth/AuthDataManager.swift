//
//  AuthDataManager.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

class AuthDataManager: AuthRepository {
    private let provider: AuthRepositoryProvider
    
    init(provider: AuthRepositoryProvider = AuthRemoteRepositoryProvider()) {
        self.provider = provider
    }
    
    // MARK: - AuthRepository
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.provider.signIn(email: email, password: password, completion: completion)
    }
}
