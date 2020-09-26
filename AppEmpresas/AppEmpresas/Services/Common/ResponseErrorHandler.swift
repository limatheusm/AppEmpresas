//
//  ResponseErrorHandler.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

class ResponseErrorHandler {
    static let kGenericError = "Something went wrong"
    
    static func handle(response: Response, domain: String) -> Error {
        guard let enterpriseResponseError = try? response.map(ResponseError.self) else {
            return self.getGenericErrorMessage(domain: domain)
        }
        
        return NSError(
            domain: domain,
            code: response.statusCode,
            userInfo: [NSLocalizedDescriptionKey: enterpriseResponseError.errors?.first ?? ""]
        )
    }
    
    static func getGenericErrorMessage(domain: String) -> Error {
        return NSError(
            domain: domain,
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: kGenericError]
        )
    }
}
