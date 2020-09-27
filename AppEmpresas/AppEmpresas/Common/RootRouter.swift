//
//  RootWireframe.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 27/09/20.
//

import Foundation
import UIKit

protocol RootRouterProtocol: class {
    func setupRootViewcontroller()
    func switchRootViewController(isSignedIn: Bool)
}

class RootRouter: RootRouterProtocol {
    var window: UIWindow?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    // MARK: - RootRouterProtocol
    
    func setupRootViewcontroller() {
        self.switchRootViewController(isSignedIn: false)
    }
    
    func switchRootViewController(isSignedIn: Bool) {
        // TODO: Implement EnterpriseRouter [ML]
        self.window?.rootViewController = isSignedIn ? UIViewController() : AuthRouter.createModule(rootRouter: self)
        self.window?.makeKeyAndVisible()
    }
}
