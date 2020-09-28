//
//  SearchRouter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

class SearchRouter: SearchPresenterToRouterProtocol {
    var rootRouter: RootRouterProtocol?
    
    static func createModule(rootRouter: RootRouterProtocol) -> UINavigationController {
        let navigationController = UINavigationController()
        let searchViewController = SearchViewController()
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [searchViewController]
        let interactor = SearchInteractor()
        let router = SearchRouter(rootRouter: rootRouter)
        let presenter = SearchPresenter(view: searchViewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        searchViewController.presenter = presenter
        
        return navigationController
    }
    
    init(rootRouter: RootRouterProtocol) {
        self.rootRouter = rootRouter
    }
    
    func switchToSignOut() {
        self.rootRouter?.switchRootViewController(isSignedIn: false)
    }
}
