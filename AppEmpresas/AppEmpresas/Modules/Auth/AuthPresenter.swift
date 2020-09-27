//
//  AuthPresenter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation

class AuthPresenter: AuthViewToPresenterProtocol {
    // MARK: - Outputs
    weak var view: AuthPresenterToViewProtocol?
    var interactor: AuthPresenterToInteractorProtocol?
    var router: AuthPresenterToRouterProtocol?
    
    init(view: AuthPresenterToViewProtocol,
         interactor: AuthPresenterToInteractorProtocol,
         router: AuthPresenterToRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func signIn(email: String, password: String) {
        self.view?.showLoading()
        self.interactor?.signIn(email: email, password: password)
    }
}

extension AuthPresenter: AuthInteractorToPresenterProtocol {
    func fetchAuthSuccess() {
        self.view?.hideLoading()
        self.view?.onFetchAuthSuccess()
        self.router?.switchToSignIn()
    }
    
    func fetchAuthFailure(error: Error) {
        self.view?.hideLoading()
        self.view?.onFetchAuthFailure(errorMessage: error.localizedDescription)
    }
}
