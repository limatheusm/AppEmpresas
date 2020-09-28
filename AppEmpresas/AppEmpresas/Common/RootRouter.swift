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
        self.window?.rootViewController = isSignedIn
            ? SearchRouter.createModule(rootRouter: self)
            : AuthRouter.createModule(rootRouter: self)
        self.window?.makeKeyAndVisible()
    }
}
