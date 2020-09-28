//
//  SearchRouter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

enum SearchDestination {
    case enterpriseDetails(enterprise: Enterprise)
    
    var context: UIViewController {
        switch self {
        case .enterpriseDetails(let enterprise):
            return EnterpriseDetailsRouter.createModule(enterprise: enterprise)
        }
    }
}

class SearchRouter: SearchPresenterToRouterProtocol {
    var rootRouter: RootRouterProtocol?
    var context: UINavigationController
    
    static func createModule(rootRouter: RootRouterProtocol) -> UINavigationController {
        let navigationController = UINavigationController()
        let searchViewController = SearchViewController()
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [searchViewController]

        let interactor = SearchInteractor()
        let router = SearchRouter(rootRouter: rootRouter, context: navigationController)
        let presenter = SearchPresenter(view: searchViewController, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        searchViewController.presenter = presenter
        
        return navigationController
    }
    
    init(rootRouter: RootRouterProtocol, context: UINavigationController) {
        self.rootRouter = rootRouter
        self.context = context
    }
    
    func switchToSignOut() {
        self.rootRouter?.switchRootViewController(isSignedIn: false)
    }
    
    func push(destination: SearchDestination) {
        self.context.pushViewController(destination.context, animated: true)
    }
    
}
