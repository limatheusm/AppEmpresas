//
//  AuthServiceProtocols.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

protocol AuthRepository {
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol AuthRepositoryProvider {
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol AuthAPIProtocol {
    func requestSignIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
