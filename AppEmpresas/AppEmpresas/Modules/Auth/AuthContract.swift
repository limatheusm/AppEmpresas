//
//  AuthProtocols.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol AuthPresenterToViewProtocol: PresenterToViewProtocol {
    func onFetchAuthSuccess()
    func onFetchAuthFailure(errorMessage: String)
    func showLoading()
    func hideLoading()
}

// MARK: View Input (View -> Presenter)
protocol AuthViewToPresenterProtocol: ViewToPresenterProtocol {
    // MARK: - Outputs
    var view: AuthPresenterToViewProtocol? { get set }
    var interactor: AuthPresenterToInteractorProtocol? { get set }
    var router: AuthPresenterToRouterProtocol? { get set }

    func signIn(email: String, password: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol AuthPresenterToInteractorProtocol: PresenterToInteractorProtocol {
    var presenter: AuthInteractorToPresenterProtocol? { get set }
    
    func signIn(email: String, password: String)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol AuthInteractorToPresenterProtocol: InteractorToPresenterProtocol {    
    func fetchAuthSuccess()
    func fetchAuthFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol AuthPresenterToRouterProtocol: PresenterToRouterProtocol {
    static func createModule(rootRouter: RootRouterProtocol) -> UIViewController
    
    func switchToSignIn()
}
