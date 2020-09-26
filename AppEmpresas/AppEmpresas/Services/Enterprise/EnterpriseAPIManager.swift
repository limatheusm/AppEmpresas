//
//  EnterpriseAPIManager.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation
import Moya

class EnterpriseAPIManager: EnterpriseAPIProtocol {
    private static let kDomain = String(describing: EnterpriseAPIManager.self)
    
    private let provider = MoyaProvider<EnterpriseAPI>(plugins: [AuthPlugin()])
    
    // MARK: - EnterpriseAPIProtocol
    
    func list(name: String?, type: Int?, completion: @escaping (Result<[Enterprise], Error>) -> Void) {
        self.provider.request(.list(name: name, type: type)) { result in
            switch result {
            case .failure:
                completion(.failure(ResponseErrorHandler.getGenericErrorMessage(domain: Self.kDomain)))
            case .success(let response):
                do {
                    let enterprisesResponse = try response
                        .filterSuccessfulStatusCodes()
                        .map(EnterprisesResponse.self)
                    
                    guard let enterprises = enterprisesResponse.enterprises else {
                        throw NSError()
                    }
                    
                    completion(.success(enterprises))
                } catch {
                    let error = ResponseErrorHandler.handle(response: response, domain: Self.kDomain)
                    completion(.failure(error))
                }
            }
        }
    }
    
    func show(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void) {
        self.provider.request(.show(id: id)) { result in
            switch result {
            case .failure:
                completion(.failure(ResponseErrorHandler.getGenericErrorMessage(domain: Self.kDomain)))
            case .success(let response):
                do {
                    let enterpriseResponse = try response
                        .filterSuccessfulStatusCodes()
                        .map(EnterpriseResponse.self)
                    
                    guard enterpriseResponse.success == true, let enterprise = enterpriseResponse.enterprise else {
                        throw NSError()
                    }
                    
                    completion(.success(enterprise))
                } catch {
                    let error = ResponseErrorHandler.handle(response: response, domain: Self.kDomain)
                    completion(.failure(error))
                }
            }
        }
    }
}
