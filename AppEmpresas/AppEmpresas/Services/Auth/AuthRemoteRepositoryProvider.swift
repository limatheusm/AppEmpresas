//
//  AuthRemoteRepositoryProvider.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

class AuthRemoteRepositoryProvider: AuthRepositoryProvider {
    private let api: AuthAPIProtocol
    
    init(api: AuthAPIProtocol = AuthAPIManager()) {
        self.api = api
    }
    
    // MARK: - AuthRepositoryProvider
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.api.requestSignIn(email: email, password: password, completion: completion)
    }
}
