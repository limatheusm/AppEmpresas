//
//  EnterpriseServiceProtocols.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 26/09/20.
//

import Foundation

protocol EnterpriseRepository {
    func getEnterprises(name: String?, type: Int?, completion: @escaping (Result<[Enterprise], Error>) -> Void)
    func getEnterprise(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void)
}

protocol EnterpriseRepositoryProvider {
    func fetchEnterprises(name: String?, type: Int?, completion: @escaping (Result<[Enterprise], Error>) -> Void)
    func fetchEnterprise(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void)
}

protocol EnterpriseAPIProtocol {
    func list(name: String?, type: Int?, completion: @escaping (Result<[Enterprise], Error>) -> Void)
    func show(id: Int, completion: @escaping (Result<Enterprise, Error>) -> Void)
}
