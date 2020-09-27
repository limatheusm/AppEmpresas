//
//  AuthRouter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

class AuthRouter: AuthPresenterToRouterProtocol {
    var rootRouter: RootRouterProtocol?
    
    static func createModule(rootRouter: RootRouterProtocol) -> UIViewController {
        let authViewController = AuthViewController()
        let interactor = AuthInteractor()
        let router = AuthRouter(rootRouter: rootRouter)
        let presenter = AuthPresenter(view: authViewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        authViewController.presenter = presenter
        
        return authViewController
    }
    
    init(rootRouter: RootRouterProtocol) {
        self.rootRouter = rootRouter
    }
    
    func switchToSignIn() {
        self.rootRouter?.switchRootViewController(isSignedIn: true)
    }
}
