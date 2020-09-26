//
//  AuthAPIManager.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

enum AuthAPIHeader: String {
    case accessToken = "access-token"
    case client = "client"
    case uid = "uid"
}

class AuthAPIManager: AuthAPIProtocol {
    private static let kDomain = String(describing: AuthAPIManager.self)
    
    private let provider = MoyaProvider<AuthAPI>()
    
    // MARK: - AuthAPIProtocol
    
    func requestSignIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.provider.request(.signIn(email: email, password: password)) { result in
            switch result {
            case .failure:
                completion(.failure(ResponseErrorHandler.getGenericErrorMessage(domain: Self.kDomain)))
            case .success(let response):
                do {
                    let authResponse = try response.filterSuccessfulStatusCodes().map(AuthResponse.self)
                    
                    guard authResponse.success == true,
                          let accessToken = response.response?.value(forHTTPHeaderField: AuthAPIHeader.accessToken.rawValue),
                          let uid = response.response?.value(forHTTPHeaderField: AuthAPIHeader.uid.rawValue),
                          let client = response.response?.value(forHTTPHeaderField: AuthAPIHeader.client.rawValue) else {
                        throw NSError()
                    }
                    
                    AuthKeyChainManager.shared.storeAuth(accessToken: accessToken, client: client, uid: uid)
                    completion(.success(true))
                } catch {
                    let error = ResponseErrorHandler.handle(response: response, domain: Self.kDomain)
                    completion(.failure(error))
                }
            }
        }
    }
}
