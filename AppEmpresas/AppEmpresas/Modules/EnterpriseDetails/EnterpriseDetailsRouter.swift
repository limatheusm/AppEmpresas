//
//  EnterpriseDetailsRouter.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 28/09/20.
//

import Foundation
import UIKit

class EnterpriseDetailsRouter: EnterpriseDetailsPresenterToRouterProtocol {
    var context: UIViewController
    
    static func createModule(enterprise: Enterprise) -> UIViewController {
        let view = EnterpriseDetailsViewController()
        let router = EnterpriseDetailsRouter(context: view)
        let presenter = EnterpriseDetailsPresenter(view: view, router: router, enterprise: enterprise)
        
        view.presenter = presenter
        
        return view
    }
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func pop() {
        self.context.navigationController?.popViewController(animated: true)
    }
}
