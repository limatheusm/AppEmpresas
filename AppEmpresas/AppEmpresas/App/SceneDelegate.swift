//
//  SceneDelegate.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 25/09/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var rootRouter: RootRouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.rootRouter = RootRouter(windowScene: windowScene)
            self.rootRouter?.setupRootViewcontroller()
        }
    }
}
