//
//  AuthKeyChainManager.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import KeychainSwift

class AuthKeyChainManager {
    static let shared = AuthKeyChainManager()
    
    private let kAuthCredentialsKey = "auth_credentials_key"
    
    private let keychain = KeychainSwift()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func storeAuth(accessToken: String, client: String, uid: String) {
        let authCredentials = AuthCredentials(accessToken: accessToken, client: client, uid: uid)
        
        guard let authCredentialsEncoded = try? self.encoder.encode(authCredentials) else {
            return
        }
        
        self.keychain.set(authCredentialsEncoded, forKey: kAuthCredentialsKey)
    }
    
    func getAuthStoraged() -> AuthCredentials? {
        guard let authCredentialsData = self.keychain.getData(kAuthCredentialsKey) else {
            return nil
        }
        
        return try? self.decoder.decode(AuthCredentials.self, from: authCredentialsData)
    }
}

