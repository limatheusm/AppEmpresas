//
//  AuthAPI.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

enum AuthAPI {
    case signIn(email: String, password: String)
}

extension AuthAPI: TargetType {
    var version: String {
        return "v1/"
    }
    
    var baseURL: URL {
        return URL(string: "https://empresas.ioasys.com.br/api/\(self.version)")!
    }
    
    var path: String {
        return "users/auth/sign_in"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signIn(let email, let password):
            var parameters = [String: Any]()
            parameters.add(value: email, forKey: "email")
            parameters.add(value: password, forKey: "password")
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

