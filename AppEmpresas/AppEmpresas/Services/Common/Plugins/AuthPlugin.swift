//
//  AuthPlugin.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
    var authCredentials: AuthCredentials? {
        AuthKeyChainManager.shared.getAuthStoraged()
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let authCredentials = self.authCredentials else {
            return request
        }
        
        var request = request
        request.addValue(authCredentials.accessToken, forHTTPHeaderField: AuthAPIHeader.accessToken.rawValue)
        request.addValue(authCredentials.uid, forHTTPHeaderField: AuthAPIHeader.uid.rawValue)
        request.addValue(authCredentials.client, forHTTPHeaderField: AuthAPIHeader.client.rawValue)
        return request
    }
}
