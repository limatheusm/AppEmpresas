//
//  EnterpriseDetailsContract.swift
//  AppEmpresas
//
//  Created by Matheus Lima on 28/09/20.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol EnterpriseDetailsPresenterToViewProtocol {
    var presenter: EnterpriseDetailsViewToPresenterProtocol? { get set }
    
    func setupEnterpriseDetails(enterprise: Enterprise)
}

// MARK: View Input (View -> Presenter)
protocol EnterpriseDetailsViewToPresenterProtocol {
    var enterprise: Enterprise { get set }
    // MARK: - Outputs
    var view: EnterpriseDetailsPresenterToViewProtocol? { get set }
    var router: EnterpriseDetailsPresenterToRouterProtocol? { get set }
    
    func viewDidLoad()
    func onBackButtonTap()
}

// MARK: Router Input (Presenter -> Router)
protocol EnterpriseDetailsPresenterToRouterProtocol {
    static func createModule(enterprise: Enterprise) -> UIViewController
    var context: UIViewController { get }
    
    func pop()
}
