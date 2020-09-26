//
//  EnterpriseAPI.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

enum EnterpriseAPI {
    case list(name: String?, type: Int?)
    case show(id: Int)
}

extension EnterpriseAPI: TargetType {
    var version: String {
        return "v1/"
    }
    
    var baseURL: URL {
        return URL(string: "https://empresas.ioasys.com.br/api/\(self.version)")!
    }
    
    var path: String {
        switch self {
        case .list:
            return "enterprises"
        case .show(let id):
            return "enterprises/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var parameters = [String: Any]()
        
        switch self {
        case .list(let name, let type):
            parameters.add(value: name, forKey: "name")
            parameters.add(value: type, forKey: "enterprise_types")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .show:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

