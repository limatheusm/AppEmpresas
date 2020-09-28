//
//  AuthInteractor.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

class AuthInteractor: AuthPresenterToInteractorProtocol {
    var repository: AuthRepository?
    // MARK: - Output
    weak var presenter: AuthInteractorToPresenterProtocol?
    
    init(repository: AuthRepository = AuthDataManager()) {
        self.repository = repository
    }
    
    func signIn(email: String, password: String) {
        self.repository?.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.presenter?.fetchAuthFailure(error: error)
            case .success:
                self?.presenter?.fetchAuthSuccess()
            }
        }
    }
}
